#encoding:UTF-8
require 'spec_helper'

describe CommentsController do
  render_views
  
  describe "access control" do
    it "should deny create control" do
      post :create
      response.should redirect_to(root_path)
    end   
    it "should deny delete control" do
      delete :destroy, :id => 1
      response.should redirect_to(root_path)
    end
  end
  
  describe "DELETE 'destroy" do
 
    describe "for an unauthorized user" do
      it "should not destroy comment" do
        lambda do
          post :destroy, :id => 1
        end.should_not change(Comment,:count)
      end  
    end

    describe"for an authorized user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @user.id, :kitable_type => "User")
        @comment = Factory(:comment, :user => @user, :kit => @kit)
      end
      it "should destroy the comment" do
        lambda do
          delete :destroy, :id => @comment
        end.should change(Comment, :count).by(-1)
      end
    end
  end
  
  describe "'POST'create'" do
    
    describe "comment to user kit" do
      before(:each) do
       @user = test_sign_in(Factory(:user))
       @kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @user.id, :kitable_type => "User")
      end
  
      describe "failure" do 
        before(:each) do
          @attr = {:content => "", :kit_id =>@kit.id}
        end 
        it "should not create a comment" do
          lambda do
            post :create, :comment => @attr
          end.should_not change(Comment,:count)
        end
      end
    
      describe "success" do
        before(:each) do
         @attr = {:content => "test", :kit_id => @kit.id}
        end  
        it "should create a comment" do
          lambda do
            post :create, :comment => @attr
          end.should change(Comment,:count).by(1)
        end
      end
    end
    
    describe "comment to seed kit" do  
      before(:each) do
       @user = test_sign_in(Factory(:user))
       @seed = Factory(:seed, :user => @user)
       @kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @seed.id, :kitable_type => "Seed")
      end
      describe "failure" do  
        before(:each) do
          @attr = {:content => "", :kit_id =>@kit.id}
        end 
        it "should not create a comment" do
          lambda do
            post :create, :comment => @attr
          end.should_not change(Comment,:count)
        end
      end
    
      describe "success" do
        before(:each) do
         @attr = {:content => "test", :kit_id => @kit.id}
        end 
        it "should create a comment" do
          lambda do
            post :create, :comment => @attr
          end.should change(Comment,:count).by(1)
        end
      end 
    end       
  end  
end
