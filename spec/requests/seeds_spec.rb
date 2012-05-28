#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Seeds" do
  
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
  end
  
  describe "GET /seeds", :js => true do
    it "displays seeds" do
      @user.seeds.create!(:title => "test seed title", :description => "test seed description about ..")
      visit seeds_path
      page.should have_content("test seed title")
      page.should have_content("test seed description about ..")
    end
  end
    
  describe "POST /seeds" do
    it "create seeds" do
     visit seeds_path
     fill_in "seed_title", :with => "test seed title"
     fill_in "seed_description", :with => "test seed description about .."
     click_button "시드 만들기"
     page.should have_content("test seed description about ..")
    end
  end
  
  describe "Destroy /seeds", :js => true do
    it "displays seeds" do
      @seed = @user.seeds.create!(:title => "test seed title", :description => "test seed description about ..")
      @seed.destroy
      visit seeds_path
      page.should_not have_content("test seed description about ..")
    end
  end
end