#encoding:UTF-8
require 'spec_helper'

describe Friendship do
  
  before(:each) do
    @user = Factory(:user)
    @another_user = Factory(:user, :email => Factory.next(:email))
    @attr = {:friend_id => @another_user.id, :status => "pending"}
    @reverse_attr = {:friend_id => @user.id, :status => "request"}
    @friendship = @user.friendships.build(:friend_id => @another_user.id, :status =>"pending")
    @reverse_friendship = @another_user.friendships.build(:friend_id => @user.id, :status => "requested")   
  end 
  it "shoud create two new instances given valid attributes " do
    @friendship.save!
    @reverse_friendship.save!
  end
  
  describe "user associations" do   
    before(:each) do
      @friendship = @user.friendships.create(@attr)
      @reverse_friendship = @another_user.friendships.create(@reverse_attr)
    end 
    it "should have a user attribute" do
      @friendship.should respond_to(:user)
      @reverse_friendship.should respond_to(:user)
    end    
    it "should have the right associated user" do
      @friendship.user.should == @user
      @reverse_friendship.user.should == @another_user
      @friendship.user_id.should == @user.id
      @reverse_friendship.user_id.should == @another_user.id      
    end   
  end
  
  describe "friend associatons" do 
    before(:each) do
      @friendship = @user.friendships.create(@attr)
      @reverse_friendship = @another_user.friendships.create(@reverse_attr)
    end  
    it "should have a friend attribute" do
      @friendship.should respond_to(:friend)
      @reverse_friendship.should respond_to(:friend)
    end   
    it "should have the right associated user" do
      @friendship.friend.should == @another_user
      @reverse_friendship.friend.should == @user
      @friendship.friend_id.should == @another_user.id
      @reverse_friendship.friend_id.should == @user.id      
    end
  end
   
  describe "validations" do
    it "should have require a user id" do
        Friendship.new(@attr).should_not be_valid
    end  
    it "should have require a friend id" do
      @user.friendships.build(@attr.merge(:friend_id => " ")).should_not be_valid
    end  
    it "should have require a status" do
      @user.friendships.build(@attr.merge(:status => " ")).should_not be_valid
    end   
    it "should not have the wrong status" do
      @user.friendships.build(:friend_id => @another_user, :status => "test").should_not be_valid
    end   
    it "should have the right status" do
      @another_user.friendships.build(:friend_id => @user , :status => "requested").should be_valid
      @user.friendships.build(:friend_id => @another_user, :status => "pending").should be_valid
    end  
    it "should require a right status" do
        @friendship.status.should == "pending"
        @reverse_friendship.status.should == "requested"
    end
  end
end