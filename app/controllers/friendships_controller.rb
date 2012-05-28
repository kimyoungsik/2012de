# encoding: UTF-8
class FriendshipsController < ApplicationController
  
  before_filter :authenticate_user!
  def create
    @friendship = current_user.friendships.build(params[:friendship])
    @friendship.status = "pending"
    @friend = @friendship.friend
    if @friend
      @reverse_friendship = @friend.friendships.build(:friend_id => current_user.id, :status => 'requested')
      if @friendship.save and @reverse_friendship.save
        # Notification.notify(@friendship.friend_id, "friendship_notification", @friendship.id, "Friendship", current_user.id)
        respond_to do |format|
          format.html { redirect_to users_path }
          format.js
        end
      else
        redirect_to users_path
      end
    else
      redirect_to users_path
    end
  end
  
  def update
    @user = current_user
    @f1 = Friendship.find(params[:id])
    @friend = @f1.friend
    @f2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)    
    
    unless @f1.nil?
      if @f1.update_attributes(:status => "accepted") and @f2.update_attributes(:status => "accepted")
        Notification.notify(@f1.friend_id, "friendship_acceptance_notification", @f1.id, "Friendship", current_user.id)
        respond_to do |format|
          format.html { redirect_back_or root_path }
          format.js
        end
      else
        redirect_to root_path
      end
    end  
  end
  
  def destroy
    @user = current_user
    @friendship = Friendship.find(params[:id])
    @friend = @friendship.friend

    @f1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @f2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)

    unless @f1.nil?
      @f1.destroy 
      @f2.destroy
    end
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end
end
