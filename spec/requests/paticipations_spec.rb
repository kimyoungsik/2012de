#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Participations" do
  
  describe "participate in seed" do
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
    
    describe "GET /Participations", :js => true do
      it "displays participations"do
        @user.participations.create!(:seed_id => @seed.id, :status=> "progress", :user_id => @user.id)
        visit seed_path(@seed)
        page.should have_content("이 시드에 참여했습니다.")
      end
    end
    
    describe "UPDATE /Participations", :js => true do
      it "displays success"do
        @participation=@user.participations.create!(:seed_id => @seed.id, :status=> "progress", :user_id => @user.id)
        @participation.update_attributes(:status => "complete")
        visit seed_path(@seed)
        page.should have_content("이 시드를 성공했습니다.")
      end
    end
  end  
end