#encoding:UTF-8
require 'spec_helper'

describe KitsController do
  render_views
  
  describe "access control" do   
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end     
    it "should deny access to 'destroy'"do
      delete :destroy ,:id => 1
      response.should redirect_to(root_path)
    end
  end
  
  describe "GET 'index'" do
        
    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @kits = []
        5.times do |n|
          @kits << @user.authored_kits.create!(:content => "#{n}번 kit입니다. 이렇게 살고 있어요!", :kitable_id => @user.id, :kitable_type => "User")
        end
      end    
      it "should be successful" do
        get :index
        response.should be_success
      end    
      it "should have the right title" do
        get 'index'
        response.should have_selector("title", :content => "시내 | DreamKit")
      end
      
      it "should have an element for each kit" do
        get :index
        @kits[0..2].each do |kit| 
          response.should have_selector("div", :content => kit.content)
        end
      end
    end
  end
   
  describe "POST 'create'" do
  
    describe "kit in user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
    
      describe "failure" do   
        before(:each) do
          @attr = { :content => "", :kitable_id => @user.id, :kitable_type => "" }
        end    
        it "should not create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should_not change(Kit, :count)
        end      
      end
    
      describe "success" do    
        before(:each) do
          @attr = { :content => "test content", :kitable_id => @user.id, :kitable_type => "User"}
        end     
        it "should create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should change(Kit, :count).by(1)
        end     
      end
    end
    
    describe "kit in seed" do
     before(:each) do
        @user = test_sign_in(Factory(:user))
        @seed = Factory(:seed, :user => @user)
      end

      describe "failure" do
        before(:each) do
          @attr = { :content => "", :kitable_id => @seed.id, :kitable_type => "" }
        end
        it "should not create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should_not change(Kit, :count)
        end
      end

      describe "success" do
        before(:each) do
          @attr = { :content => "test content", :kitable_id => @seed.id, :kitable_type => "Seed"}
        end
        it "should create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should change(Kit, :count).by(1)
        end
      end    
    end
    
    describe "kit in network" do
     before(:each) do
        @user = test_sign_in(Factory(:user))
        @network = Factory(:network)
      end

      describe "failure" do
        before(:each) do
          @attr = { :content => "", :kitable_id => @network.id, :kitable_type => "" }
        end
        it "should not create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should_not change(Kit, :count)
        end
      end

      describe "success" do
        before(:each) do
          @attr = { :content => "test content", :kitable_id => @network.id, :kitable_type => "Network"}
        end
        it "should create a kit" do
          lambda do
            post :create, :kit => @attr
          end.should change(Kit, :count).by(1)
        end
      end    
    end    
  end
   
  describe "DELETE 'destroy'" do
    
    describe "for an unauthorized user" do    
      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @kit = @user.authored_kits.create!(:content => "Foobar", :kitable_id => @user.id, :kitable_type => "User")
      end    
      it "should deny access" do
        post :destroy, :id => @kit
        response.should redirect_to(kits_path) 
      end
      it "should not destroy the kit" do        
        lambda do
          post :destroy, :id => @kit
        end.should_not change(Kit, :count)
      end    
    end
    
    describe "for an authorized user" do
      
      describe "kit in user" do
        before(:each) do
          @user = test_sign_in(Factory(:user))
          @kit = @user.authored_kits.create!(:content => "Foobar", :kitable_id => @user.id, :kitable_type => "User")
        end   
        it "should destroy the kit" do
          lambda do
            post :destroy, :id =>@kit
          end.should change(Kit, :count).by(-1)
        end   
        it "should show index page" do
          post :destroy, :id => @kit
          response.should redirect_to(kits_path)
        end
      end
      
      describe "kit in seed" do
        before(:each) do
          @user = test_sign_in(Factory(:user))
          @seed = Factory(:seed, :user => @user)
          @kit = @user.authored_kits.create!(:content => "Foobar", :kitable_id => @seed.id, :kitable_type => "Seed")
        end
        it "should destroy the kit" do
          lambda do
            post :destroy, :id =>@kit
          end.should change(Kit, :count).by(-1)
        end
        it "should show index page" do
          post :destroy, :id => @kit
          response.should redirect_to(kits_path)
        end
      end

      describe "kit in network" do
        before(:each) do
          @user = test_sign_in(Factory(:user))
          @network = Factory(:network)
          @kit = @user.authored_kits.create!(:content => "Foobar", :kitable_id => @network.id, :kitable_type => "Network")
        end
        it "should destroy the kit" do
          lambda do
            post :destroy, :id =>@kit
          end.should change(Kit, :count).by(-1)
        end
        it "should show index page" do
          post :destroy, :id => @kit
          response.should redirect_to(kits_path)
        end
      end      
    end
  end
end
