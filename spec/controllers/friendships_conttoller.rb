#encoding:UTF-8
require 'spec_helper'

describe FriendshipsController do
  render_views  
  before(:each) do
    @user = Factory(:user)
    @another_user = Factory(:user, :email => Factory.next(:email))
    @wrong_user = Factory(:user, :email => Factory.next(:email))
  end
 
  describe "access control" do
    it "should deny access to 'create'"do
      post :create
      response.should redirect_to(root_path)
    end 
    it "should deny access to 'update'"do
      post :update , :id => 1
      response.should redirect_to(root_path)
    end  
    it "should deny access to 'destroy'"do
      delete :destroy, :id => 1
      response.should redirect_to(root_path)
    end   
  end
  
  describe "POST 'create'" do
    before(:each) do
      test_sign_in(@user)
    end  
    
    describe 'failure' do
      it "should not create a Friendship" do
        lambda do
          post :create, :friendship => {:friend_id => ""}
        end.should_not change(Friendship, :count)  
      end  
      it "should not create a Friendship" do
        lambda do
          post :create, :friendship => {:friend_id => @user.id}
        end.should_not change(Friendship, :count)  
      end    
    end
    
    describe 'success' do
      it "should create a friendship" do
        lambda do
          post :create, :friendship => {:friend_id => @another_user.id}
        end.should change(Friendship, :count).by(2)
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @friendship = @user.friendships.create!(:friend_id => @another_user.id, :status =>"pending")
      @reverse_friendship = @another_user.friendships.create!(:friend_id => @user.id, :status => "requested")
    end
  
    describe "for an unauthorized user" do  
      before(:each) do
        test_sign_in(@wrong_user)    
      end
      it "should deny access" do
        put :update, :id => @reverse_friendship
        response.should redirect_to(root_path)
      end
    end
    
    describe "for an authorized user" do  
      before(:each) do
        test_sign_in(@user)
      end   
      it "should success" do
        put :update, :id => @reverse_friendship
        Friendship.last.status.should == "accepted"
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    
    describe "for an unauthorized user"do  
      before(:each) do
        test_sign_in(@wrong_user)
        @friendship = @user.friendships.create!(:friend_id=>@another_user.id, :status => "pending")
        @reverse_friendship = @another_user.friendships.create!(:friend_id=> @user.id, :status => "requested")
      end    
      it "should deny access" do     
        delete :destroy, :id => @friendship
        response.should redirect_to(root_path)      
      end     
      it "should not destroy the friendship" do
        lambda do
          delete :destroy, :id => @friendship
          response.should_not change(Friendship, :count)
        end  
      end
    end
    
    describe "for an authorized user" do
      before(:each) do
        @friendship = @user.friendships.create!(:friend_id=>@another_user.id, :status => "pending")
        @reverse_friendship = @another_user.friendships.create!(:friend_id=> @user.id, :status => "requested")
      end
      
      describe "for a user who has a status 'pending'" do
        before(:each) do
           test_sign_in(@user)
        end   
        it "should destroy the friendship" do         
          lambda do
            delete :destory, :id => @friendship
            response.should change(Friendship, :count).by(-2)
          end
        end
      end
      
      describe "for a user who has a status 'request'" do
        before(:each) do
           test_sign_in(@another_user)
        end     
        it "should destroy the friendship" do        
          lambda do
            delete :destory, :id => @friendship
            response.should change(Friendship, :count).by(-2)
          end
        end
      end
    end
  end
end
  
  