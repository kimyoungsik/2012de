#encoding:UTF-8
require 'spec_helper'

describe "Users" do

  describe "signup" do
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit root_path
          click_link "로그인"
          # click_link "로그인"
          click_link "회원가입"
          fill_in "user_name", :with => ""
          fill_in "user_email", :with => ""
          fill_in "user_password", :with => ""
          fill_in "user_password_confirmation", :with => ""
          click_button "시작하기"
          # response.should render_template(root_path)
        end.should_not change(User, :count)
      end
    end
    
    # describe "success" do
    #   it "should make a new user" do
    #     lambda do
    #       visit root_path
    #       click_link "로그인"
    #       # click_link "로그인"
    #       click_link "회원가입"
    #       fill_in "user_name", :with => "박길동"
    #       fill_in "user_email", :with => "doly123@headflow.net"
    #       fill_in "user_password", :with => "123456"
    #       fill_in "user_password_confirmation", :with => "123456"
    #       click_button "시작하기"
    #       response.should render_template(root_path)
    #     end.should change(User, :count).by(1)
    #   end      
    # end
  end
  
  
  
  describe "signin" do
    
    describe "failure" do
      it "should not signin" do
        lambda do
          visit root_path
          click_link "로그인"
          fill_in "user_email", :with => ""
          fill_in "user_password", :with => ""
          click_button "로그인"
          response.should render_template(root_path)
        end
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit root_path
          click_link "로그인"
          # click_link "로그인"
          fill_in "user_email", :with => "doly1@headflow.net"
          fill_in "user_password", :with => "dudtlr"      
          click_button "로그인"
          response.should render_template(root_path)
        end
      end      
    end
  end
end
