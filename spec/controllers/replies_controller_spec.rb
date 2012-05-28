require 'spec_helper'

describe RepliesController do
  render_views
    
  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(root_path)
    end                                     
  end
  
  describe "POST 'create'" do 
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @user2 = Factory(:user, :email => Factory.next(:email))    
      @user3 = Factory(:user, :email => Factory.next(:email))    
      @ids = []
      @ids.push(@user2.id)
      @ids.push(@user3.id)
      @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}  
      @message = Message.create!(@attr)
    end
    
    describe "success" do
      before(:each) do
        @attr = {:message_id => @message.id, :content => @message.content}
      end
      it "should create a seed" do
        lambda do
          post :create, :reply => @attr
        end.should change(Reply, :count).by(1)
      end      
    end
     
    describe "fail" do
    
      describe "should have content" do
        before(:each) do
          @attr = {:message_id => @message.id, :content => ""}
        end
        it "should create a seed" do
          lambda do
            post :create, :reply => @attr
          end.should_not change(Reply, :count)
        end      
      end
      
      describe "should have message_id" do
        before(:each) do
          @attr = {:message_id => "", :content => @message.content}
        end
        it "should create a seed" do
          lambda do
            post :create, :reply => @attr
          end.should_not change(Reply, :count)
        end      
      end  
      
      describe "should not have long message_content" do
        before(:each) do
          long_content = "a"*3001
          @attr = {:message_id => @message.id, :content => long_content}
        end
        it "should create a seed" do
          lambda do
            post :create, :reply => @attr
          end.should_not change(Reply, :count)
        end      
      end
    end 
  end
end