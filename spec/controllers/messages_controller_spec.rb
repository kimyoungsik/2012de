require 'spec_helper'

describe MessagesController do

  describe "access control" do
     it "should deny access to 'index'" do
        get :index
        response.should redirect_to(root_path)
     end   
     it "should deny access to 'show'" do
        get :show,:id => 1
        response.should redirect_to(root_path)
     end     
     it "should deny access to 'create'" do
        post :create
        response.should redirect_to(root_path)
     end  
  end
  
  describe "GET 'index'" do
    before (:each)  do
      @user = test_sign_in(Factory(:user))  
    end  
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'new'" do
    before (:each)  do
      @user = test_sign_in(Factory(:user))  
    end   
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @user2 = Factory(:user, :email => Factory.next(:email))    
      @user3 = Factory(:user, :email => Factory.next(:email))    
      @ids = []
    end
   
    describe "success" do
      before(:each) do
        @ids.push(@user2.id)
        @ids.push(@user3.id)
        @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}
      end    
      it "should create a message" do
        lambda do
          post :create, :message => @attr
        end.should change(Message, :count).by(1)
      end   
      it "should redirect to message show page" do
        post :create, :message => @attr
        response.should redirect_to(message_path(assigns(:message)))
      end
    end
    
    describe "failure" do
      before(:each) do     
        @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}
      end     
      it "should not create a message" do
        lambda do
          post :create, :message => @attr
        end.should_not change(Message, :count)
      end     
      it "should redirect to message index page" do
        post :create, :message => @attr
        response.should render_template('index')
      end
    end
  end
end
