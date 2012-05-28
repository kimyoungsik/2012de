#encoding:UTF-8
require 'spec_helper'

describe SeedsController do
  render_views
  describe "access control" do   
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end     
  end  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @seeds = []
        5.times do |n|
          @seeds << Factory(:seed, :user => @user, :title => "#{n}번 시드입니다. 도전해보자구요!")
        end
      end
      it "should be successful" do
          get :index
          response.should be_success
      end
      it "should have the right title" do
        get 'index'
        response.should have_selector("title", :content => "시드 | DreamKit")
      end
      it "should have an element for each seed" do
        get :index
        @seeds[0..2].each do |seed|
            response.should have_selector("div", :content => seed.title)
        end
      end
    end    
  end
  
  describe "POST 'create'" do 
    before(:each) do
      @user = test_sign_in(Factory(:user))    
    end
    
    describe "failure" do
      before(:each) do      
        @attr = { :title => "", :description => "" }
      end
      it "should not create a Seed" do
        lambda do
          post :create, :seed => @attr
        end.should_not change(Seed, :count)
      end           
      it "should redirect to seed new page" do
        post :create, :seed => @attr
        response.should render_template('new')
      end 
    end
    
    describe "success" do
      before(:each) do
        @attr = { :title => "Right Title", :description => "Lorem ipsum" }
      end
      it "should create a seed" do
        lambda do
          post :create, :seed => @attr
        end.should change(Seed, :count).by(1)
      end
      it "should redirect to seed show page" do
         post :create, :seed => @attr
         response.should redirect_to(seed_path(assigns(:seed)))
      end
    end
  end
  
  describe "PUT 'update'" do  
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @seed = Factory(:seed, :user => @user)
    end
  
    describe "failure" do  
      before (:each) do
        @attr = { :user_id => "", :title => "", :description => "" }
      end   
      it "should render the 'edit' page"do 
        put :update, :id => @seed, :seed => @attr
        response.should render_template('edit')
      end
    end 
  
    describe "success" do   
      before(:each) do
        @attr = { :user_id => @user.id, :title => "new title", :description => "new description"}
      end   
      it "should change the seed's attributes"do
        put :update, :id => @seed, :seed => @attr
        @seed.reload
        @seed.title.should == @attr[:title]
        @seed.description.should == @attr[:description]
      end   
      it "should redirect to the seed show page" do
        put :update, :id => @seed, :seed => @attr
        response.should redirect_to(seed_path(@seed))
      end
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @seed = Factory(:seed, :user => @user)
    end
    it "should be successful" do
      get :show, :id => @seed
      response.should be_success
    end
    it "should find the right show" do
      get :show, :id => @seed
      assigns(:seed).should == @seed
    end
    it "should have the right title" do
      get :show, :id => @seed
      response.should have_selector("title", :content => @seed.title)
    end
    it "should include the user's name" do
      get :show, :id => @seed
      response.should have_selector("h1", :content => @seed.title)
    end
  end 
  
  describe "DELETE 'destroy'" do
    
    describe "for an unauthorized user" do 
      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @seed = Factory(:seed, :user => @user)
      end    
      it "should deny access" do
        delete :destroy, :id => @seed
        response.should redirect_to(seeds_path)
      end
      it "should not destroy the seed" do
        lambda do
          delete :destroy, :id => @seed
        end.should_not change(Seed, :count)        
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @seed = Factory(:seed, :user => @user)
      end
      it "should destroy the seed" do
         lambda do
            delete :destroy, :id => @seed
         end.should change(Seed, :count).by(-1)
      end
    end
  end
end

