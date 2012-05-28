#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Tutorial" do
  
  describe "profile_network" do
    before(:each) do
      @user = Factory.create(:user)
      @user.major_id = 1
      @user.major_detail = "컴퓨터공학"
      @user.interest_id = 1
      @user.interest_id = 1
      login_as @user, :scope => :user
    end
    
    describe "write profile", :js => true do
      it "displays profile_filed" do
        visit root_path
        page.should have_content("자신을 사람들에게 어필하세요.")
        page.should have_content("빠르고 간편하게 입력하실 수 있습니다!")
        click_button "tutorial-button1"
        page.should have_content("자신이 속해있는 네트워크를 추가해보세요")
      end
    end
  end
  
  describe "network" do
    before(:each) do
      @user = Factory.create(:user)
      @user.profile = "꿈꾸는 드림키퍼"
      @user.major_id = 1
      @user.major_detail = "컴퓨터공학"
      @user.interest_id = 1
      @user.interest_id = 1
      login_as @user, :scope => :user
    end
    
    describe "add network", :js => true do
      it "displays network select_filed" do
        visit root_path
        page.should have_content("자신이 속해있는 네트워크를 추가해보세요")
      end
    end
  end   
end