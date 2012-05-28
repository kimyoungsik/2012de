# encoding: UTF-8
require 'spec_helper'

describe NotificationsController do
  
  describe "access control" do  
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'index'"  do
    
    describe "KIT_ON_SEED" do
      before(:each) do
        @seed_maker = (Factory(:user))
        @seed = Factory(:seed, :user => @seed_maker)
        @kit_maker = (Factory(:user, :email => Factory.next(:email)))
        @kit = @kit_maker.authored_kits.create!(:content => "write kit", :kitable_id => @seed.id, :kitable_type => "Seed")     
        Notification.notify(@seed_maker.id, "seed_kit_notification", @kit.id, "Kit", @kit_maker.id)
      end
      
      describe "as seed_maker" do      
         before(:each) do
            test_sign_in(@seed_maker)
         end     
         it "should get notification" do
           get :index 
           @seed_maker.unread_notifications.count.should == 1 
         end
      end
    end
    
    describe "KIT_ON_USER" do
      before(:each) do
        @user = (Factory(:user))   
        @kit_maker = (Factory(:user, :email => Factory.next(:email)))
        @kit = @kit_maker.authored_kits.create!(:content => "write kit", :kitable_id => @user.id, :kitable_type => "User")
        Notification.notify(@user.id, "kit_notification", @kit.id, "Kit", @kit_maker.id)
      end
      
      describe "as seed_maker" do 
         before(:each) do
           test_sign_in(@user)
         end      
         it "should get notification" do
           get :index 
           @user.unread_notifications.count.should == 1 
         end
      end
    end
    
    describe "COMMENT" do
      before(:each) do
        @seed_maker = Factory(:user)
        @seed = Factory(:seed, :user => @seed_maker)   
        @kit_maker = Factory(:user, :email => Factory.next(:email))
        @kit = @kit_maker.authored_kits.create!(:content => "write kit", :kitable_id => @seed.id, :kitable_type => "Seed")       
        Notification.notify(@seed_maker.id, "seed_kit_notification", @kit.id, "Kit", @kit_maker.id)  
        @user = Factory(:user, :email => Factory.next(:email))
        @comment = Factory(:comment ,:user =>@user, :kit =>@kit)
        Notification.notify(@seed_maker.id, "", @comment.id, "Comment", @user.id)
        Notification.notify(@kit_maker.id, "", @comment.id, "Comment", @user.id)
      end

      describe "as seed_maker" do   
        before(:each) do
          test_sign_in(@seed_maker)
        end        
        it "should be successful" do
          get :index
          response.should be_success
        end    
        it "should get notification" do
          @seed_maker.unread_notifications.count.should == 2
        end
      end
    
      describe "as kit_maker" do
        before(:each) do
          test_sign_in(@kit_maker)
        end      
        it "should be successful" do
           get :index
           response.should be_success
        end     
        it "should get notification" do
           @kit_maker.unread_notifications.count.should == 1
        end
      end
    end

    describe "FRIENDSHIP_REQUESTED" do    
      before(:each) do
        @user = Factory(:user)
        @another_user = Factory(:user, :email => Factory.next(:email))
        @friendship = @user.friendships.create!(:friend_id => @another_user.id, :status =>"pending")
        @reverse_friendship = @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")       
        Notification.notify(@another_user.id, "friendship_notification", @friendship.id, "Friendship", @user.id)
      end
      
      describe "get request from friend" do     
        before(:each) do
          test_sign_in(@another_user)  
        end      
        it "should get request notification" do
          get :index 
          @another_user.unread_notifications.count.should == 1
        end
      end
    end
 
    describe "FRIENDSHIP_ACCEPTANCE" do 
      before(:each) do
        @user = Factory(:user)
        @another_user = Factory(:user, :email => Factory.next(:email))
        @friendship = @user.friendships.create!(:friend_id => @another_user.id, :status =>"pending")
        @reverse_friendship = @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")  
        Notification.notify(@another_user.id, "friendship_notification", @friendship.id, "Friendship", @user.id) 
        @another_user.friendships.build(:friend_id => @user.id,:status => "accepted")
        @user.friendships.build(:friend_id => @another_user.id,:status => "accepted")  
        Notification.notify(@user.id, "friendship_acceptance_notification", @friendship.id, "Friendship", @another_user.id)
      end
     
      describe "get accepted between friends" do
        before(:each) do
          test_sign_in(@user)  
        end
        it "should get accepted notification" do
          get :index 
          @user.unread_notifications.count.should == 1
        end
      end
    end
  end
end
  
  
  
  
  

