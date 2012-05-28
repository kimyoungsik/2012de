require 'spec_helper'

describe NetworkParticipationsController do
  render_views
  
  before(:each) do
    @user = Factory(:user)
    @network = Factory(:network)
  end

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(root_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      test_sign_in(@user)
    end

    describe 'failure' do
      before(:each) do
        @attr = { :network_id => "" }
      end

      it "should not create an Network_participation" do
        lambda do
          post :create, :network_participation => @attr
        end.should_not change(NetworkParticipation, :count)
      end
    end

    describe 'success' do
      before(:each) do
        @attr = { :network_id => @network.id }
      end
      it "should create a network participation" do
        lambda do
          post :create, :network_participation => @attr
        end.should change(NetworkParticipation, :count).by(1)
      end
      it "should redirect to user page" do
        post :create, :network_participation => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @network_participation = Factory(:network_participation, :user => @user, :network => @network)
    end

    describe "for an unauthorized user" do
      before(:each) do
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
      end
      it "should deny access" do
        delete :destroy, :id => @network_participation
        response.should redirect_to(networks_path)
      end
      it "should not destroy the network participation" do
        lambda do
          delete :destroy, :id => @network_participation
        end.should_not change(NetworkParticipation, :count)
      end
    end

    describe "for an authorized user" do
      before(:each) do
        test_sign_in(@user)        
      end
      it "should destroy the network participation" do
        lambda do
          delete :destroy, :id => @network_participation
        end.should change(NetworkParticipation, :count).by(-1)
      end
    end
  end
end
