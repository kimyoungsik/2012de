#encoding:UTF-8
require 'spec_helper'
include Warden::Test::Helpers 
describe "Comments" do
  describe "comment in kit" do
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
    
    describe "GET /comments", :js => true do
      it "displays comments"do
        @comment = @user.comments.create!(:content => "test content in comment", :kit_id => @kit.id)
        visit kits_path
        page.should have_content("test content in comment")
      end
    end
    
    describe "Destroy /comments", :js => true do
      it "display comments" do
        @comment = @user.comments.create!(:content => "test content in comment", :kit_id => @kit.id)
        @comment.destroy
        visit kits_path
        page.should_not have_content("test content in comment")
      end
    end
  
    # describe "POST /comments" do
    #       it "create comments" do
    #         visit kits_path
    #         fill_in "comment-content-textarea-#{@kit.id}", :with => "test content in comment"
    #         click_button "Comment"
    #         page.should have_content("test content in comment")
    #       end
    #     end
  end
end