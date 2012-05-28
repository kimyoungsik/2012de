#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Friendships" do
  
  before(:each) do
    @user = Factory.create(:user)
    @user.major_id = 1
    @user.profile = "꿈꾸는 드림키퍼"
    @user.major_detail = "컴퓨터공학"
    @user.interest_id = 1
    @user.interest_id = 1
    @network = Factory(:network)
    @network_participation = Factory(:network_participation, :user => @user, :network => @network)
    login_as @user, :scope => :user
    @another_user = Factory.create(:user, :email => Factory.next(:email))
    @another_user.major_id = 1
    @another_user.profile = "꿈꾸는 드림키퍼"
    @another_user.major_detail = "컴퓨터공학"
    @another_user.interest_id = 1
    @another_user.interest_id = 1
    @network = Factory(:network)
    @network_participation = Factory(:network_participation, :user => @another_user, :network => @network)

  end
  
  describe "GET /Friendships", :js => true do
    it "displays pending Friendships"do
      @user.friendships.build(:friend_id => @another_user.id, :status => 'pending')
      @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")
      visit user_path(@another_user)
      page.should have_content("수락대기")
    end
    
    # describe "as another_user" do
    #   before(:each) do
    #     logout(@user)
    #     login_as @another_user, :scope => :user
    #   end
    #   it "displays request Friendships" do
    #     visit user_path(@user)
    #     page.should have_content("친구 수락")
    #   end
    # end
  end
  
  describe "UPDATE /Friendships", :js => true do
    it "displays accepted Friendships"do
      @user_friendship = @user.friendships.build(:friend_id => @another_user.id, :status => 'pending')
      @anotheruser_firendship = @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")
      @user_friendship.update_attributes(:status => "accepted")
      @anotheruser_firendship.update_attributes(:status => "accepted")
      visit user_path(@another_user)
      page.should have_content("내 친구")
    end
  end
  
  describe "Destroy /Friendships", :js => true do
    it "display Friendships" do
      @user_friendship = @user.friendships.build(:friend_id => @another_user.id, :status => 'pending')
      @anotheruser_firendship = @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")
      @user_friendship.destroy 
      @anotheruser_firendship.destroy
      visit user_path(@another_user)
      page.should_not have_content("친구 추가")
    end
  end
end