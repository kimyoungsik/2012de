#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Dittos" do
  
  describe "Dittos in kit" do
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
      @kit = @user.authored_kits.create!(:content => "test content", :kitable_id => @user.id, :kitable_type => "User")
    end

    describe "GET /Dittos", :js => true do
      it "displays Dittos"do
        @ditto = @user.dittos.create!(:dittoable_id => @kit.id, :dittoable_type => "Kit")
        visit kits_path
        page.should have_content("1명이 이 Kit을 좋아합니다.")
      end
    end

    describe "Destroy /Dittos", :js => true do
      it "display Dittos" do
        @ditto = @user.dittos.create!(:dittoable_id => @kit.id, :dittoable_type => "Kit")
        @ditto.destroy
        visit kits_path
        page.should_not have_content("1명이 이 킷을 좋아합니다.")
      end
    end
  end
  
  describe "Dittos in comment" do
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
      @kit = @user.authored_kits.create!(:content => "test content", :kitable_id => @user.id, :kitable_type => "User")
      @comment = @user.comments.create!(:content => "test content in comment", :kit_id => @kit.id)
    end
    
    describe "GET /Dittos", :js => true do
      it "displays Dittos"do
        @ditto = @user.dittos.create!(:dittoable_id => @comment.id, :dittoable_type => "Comment")
        visit kits_path
        page.should have_content("취소")
      end
    end
  end
end