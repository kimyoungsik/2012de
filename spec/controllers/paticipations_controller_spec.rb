#encoding:UTF-8
require 'spec_helper'

describe ParticipationsController do
  
  describe "access control" do  
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end
    it "should deny access to 'update'" do
      post :update
      response.should redirect_to(root_path)
    end
    it "should deny access to 'delete'" do
      delete :destroy, :id => 1
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
        @attr = {:seed_id => @seed.id, :status=> "progress", :user_id => @another_user}
      end
      it "should create a paticipation" do
        lambda do
          post :create, :participation => @attr
        end.should change(Participation, :count).by(1)
      end
      it "should redirect to seed show page" do
        post :create, :participation => @attr
        response.should redirect_to(seed_path(@seed))
      end
    end
    
    describe "failure" do
      before(:each) do
        @attr = {:seed_id => @seed.id, :status=> "", :user_id => @another_user}
      end
      it "should create a paticipation" do
        lambda do
          post :create, :participation => @attr
        end.should_not change(Participation, :count)
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @another_user = Factory(:user, :email => Factory.next(:email))
      @seed = Factory(:seed, :user => @user)
      @attr = {:seed_id => @seed.id, :status=> "progress"}
      @participation = @another_user.participations.new(@attr)
      @participation.save
    end
    
    describe "success" do   
      before(:each) do
        @updated_attr = {:seed_id => @seed.id, :status=> "complete"}
      end
      it "should change the participation's attributes"do
        put :update, :id => @participation, :participation => @updated_attr
        @participation.reload
        @participation.status.should == @updated_attr[:status]
        @participation.seed_id.should == @updated_attr[:seed_id]
      end   
    end
    
    describe "failure" do   
      before(:each) do
        @updated_attr = {:seed_id => "", :status=> ""}
      end
      it "should render the 'seed' page"do 
        put :update, :id => @participation, :seed => @updated_attr
        response.should render_template(@seed)
      end 
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @another_user = Factory(:user, :email => Factory.next(:email))
      @seed = Factory(:seed, :user => @user)
      @attr = {:seed_id => @seed.id, :status=> "progress"}
      @participation = @another_user.participations.new(@attr)
      @participation.save
    end
    it "should destroy the seed" do
      lambda do
        delete :destroy, :id => @participation
      end.should change(Participation, :count).by(-1)
    end
  end
end