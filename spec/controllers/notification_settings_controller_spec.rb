require 'spec_helper'

describe NotificationSettingsController do

  render_views

  describe "POST 'create'" do
       
    describe "success" do
      before(:each) do
        @user = test_sign_in(Factory(:user))    
        @attr = { :kit_notify => true,
        :seed_kit_notify => true,
        :moim_kit_notify => true,
        :comment_notify => true,
        :other_comment_notify => true,
        :reply_notify => true,
        :friendship_notify => true,
        :friendship_acceptance_notify => true }
      end
      it "should create a seed" do
        lambda do
          post :create, :seed => @attr
        end.should change(NotificationSetting, :count).by(1)
      end
    end
    
    describe "success without initialize" do
      before(:each) do
        @user = test_sign_in(Factory(:user))    
        @attr = {}
      end
      it "should create a seed" do
        lambda do
          post :create, :notification_setting => @attr
        end.should change(NotificationSetting, :count).by(1)
      end
    end
  end 
  
  describe "PUT 'update'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @notification_setting = Factory(:notification_setting, :user => @user)
    end
    
    describe "success" do
      before(:each) do
         @attr = { :kit_notify => false,
          :seed_kit_notify => false,
          :moim_kit_notify => false,
          :comment_notify => false,
          :other_comment_notify => false,
          :reply_notify => false,
          :friendship_notify => true,
          :friendship_acceptance_notify => true }
      end
      it "should change the notification's attributes" do
        put :update, :id => @notification_setting, :notification_setting => @attr
        @notification_setting.reload
        @notification_setting.seed_kit_notify.should == false
        @notification_setting.comment_notify.should == false
        @notification_setting.friendship_notify.should == true
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @notification_setting = Factory(:notification_setting, :user => @user)
    end
    
    describe "success" do
      it "should destroy the notification_setting" do
        lambda do
          delete :destroy, :id => @notification_setting
        end.should change(NotificationSetting, :count).by(-1)
      end  
    end
  end
end
