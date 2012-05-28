#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Supports" do
  
  describe "Supports in seed" do
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
      @seed = @user.seeds.create!(:title => "test seed title", :description => "test seed description about ..")
    end
    
    describe "GET /supports", :js => true do
      it "displays upports"do
        @user.supports.create!(:seed_id => @seed.id, :user_id => @user.id)
        visit seed_path(@seed)
        page.should have_content("이 시드를 응원했습니다.")
      end
    end
  end  
end