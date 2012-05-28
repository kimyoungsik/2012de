#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Kits" do
  
  describe "kit in sina" do
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
  
    describe "GET /kits", :js => true do
      it "displays kits"do
        @user.authored_kits.create!(:content => "test content", :kitable_id => @user.id, :kitable_type => "User")
        visit kits_path
        page.should have_content("test content")
      end
    end
  
    describe "POST /kits" do
      it "create kits" do
        visit kits_path
        fill_in "kit_content", :with => "test content"
        click_button "Kit"
        page.should have_content("test content")
      end
    end
    
    describe "Destroy /kits", :js => true do
      it "display kits" do
        @kit = @user.authored_kits.create!(:content => "test content", :kitable_id => @user.id, :kitable_type => "User")
        @kit.destroy
        visit kits_path
        page.should_not have_content("test content")
      end
    end
  end
  
  describe "kit in seed" do   
    before(:each) do
      @user = Factory.create(:user)
      login_as @user, :scope => :user
      @seed = @user.seeds.create!(:title => "test seed title", :description => "test seed description about ..")
    end
    
    describe "GET /seeds", :js => true do
      it "displays seeds"do
        @user.authored_kits.create!(:content => "test kit content in seed", :kitable_id => @seed.id, :kitable_type => "Seed")
        visit kits_path
        page.should have_content("test kit content in seed")
      end
    end
    
    describe "POST /seeds" do
      it "create seeds" do
        visit seed_path(@seed)
        fill_in "kit_content", :with => "test kit content in seed"
        click_button "Kit"
        page.should have_content("test kit content in seed")
      end
    end
    
    describe "Destroy /kits", :js => true do
      it "display kits" do
        @kit = @user.authored_kits.create!(:content => "test kit content in seed", :kitable_id => @seed.id, :kitable_type => "Seed")
        @kit.destroy
        visit kits_path
        page.should_not have_content("test kit content in seed")
      end
    end
  end
  
  describe "kit in user" do   
    before(:each) do
      @user = Factory.create(:user)
      login_as @user, :scope => :user
      @network = Network.create!(:name =>"foobar" , :network_type =>"company", :address =>"foobar@foobar.com")
    end
    
    describe "GET /seeds", :js => true do
      it "displays seeds"do
        # visit users_path(@user)
        @user.authored_kits.create!(:content => "test kit content in network", :kitable_id => @network.id, :kitable_type => "Network")
        visit kits_path
        page.should have_content("test kit content in network")
      end
    end
    
    describe "POST /seeds" do
      it "create seeds" do
        visit user_path(@user)
        fill_in "kit_content", :with => "test kit content in network"
        click_button "Kit"
        page.should have_content("test kit content in network")
      end
    end
    
    describe "Destroy /kits", :js => true do
      it "display kits" do
        @kit = @user.authored_kits.create!(:content => "test kit content in network", :kitable_id => @network.id, :kitable_type => "Network")
        @kit.destroy
        visit kits_path
        page.should_not have_content("test kit content in network")
      end
    end
  end  
end