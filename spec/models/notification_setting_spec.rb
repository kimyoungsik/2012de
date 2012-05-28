#encoding:UTF-8
require 'spec_helper'

describe NotificationSetting do
  
  before(:each) do
    @user = Factory(:user)
  end
  
  it "should create a new instance given valid attributes" do
    @notification_setting = Factory(:notification_setting, :user => @user)
  end
  
  describe "user associations" do   
    before(:each) do
     @notification_setting = Factory(:notification_setting, :user => @user)
    end   
    it "should have a user attribute" do
     @notification_setting.should respond_to(:user)
    end  
    it "should have the right associated user" do
     @notification_setting.user_id.should == @user.id
     @notification_setting.user.should == @user
    end  
  end
  
  describe "notify initialize true" do
    before(:each) do
      @notification_setting = Factory(:notification_setting, :user => @user)
    end
    it "should be true" do
      @notification_setting.seed_kit_notify.should == true
      @notification_setting.moim_kit_notify.should == true
      @notification_setting.comment_notify.should == true
      @notification_setting.other_comment_notify.should == true
      @notification_setting.reply_notify.should == true
      @notification_setting.friendship_notify.should == true
    end
  end
end 
