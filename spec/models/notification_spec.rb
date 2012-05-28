#encoding:UTF-8
require 'spec_helper'

describe Notification do
  
  before(:each) do
    @user = Factory(:user)
    @attr = {}
  end
  
  it "should create a new instance given valid attributes" do
    @user.notifications.create!(@attr)
  end
  
  describe "user associations" do   
     before(:each) do
       @notification = @user.notifications.create!(@attr)
     end   
     it "should have a user attribute" do
       @notification.should respond_to(:user)
     end  
     it "should have the right associated user" do
       @notification.user_id.should == @user.id
       @notification.user.should == @user
     end  
  end
  
  describe "validations" do
    it "should require a user id" do
      Notification.new(@attr).should_not be_valid
    end
  end
end 
