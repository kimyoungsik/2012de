#encoding:UTF-8
require 'spec_helper'

describe SupportsController do
  
  describe "access control" do  
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @another_user = Factory(:user, :email => Factory.next(:email))
      @seed = Factory(:seed, :user => @user)
    end
    
    describe "success" do
      before(:each) do
        @attr = {:seed_id => @seed.id, :user_id => @another_user}
      end
      it "should create a Support" do
        lambda do
          post :create, :support => @attr
        end.should change(Support, :count).by(1)
      end
      it "should redirect to seed show page" do
        post :create, :support => @attr
        response.should redirect_to(seed_path(@seed))
      end
    end
    
    # describe "failure" do
    #   before(:each) do
    #     @attr = {:seed_id => @seed.id}
    #   end
    #   it "should create a Support" do
    #     lambda do
    #       post :create, :support => @attr
    #     end.should_not change(Support, :count)
    #   end
    # end
  end
end