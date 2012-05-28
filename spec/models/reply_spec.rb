#encoding:UTF-8
require 'spec_helper'

describe Reply do
  
  before(:each) do
    @user = Factory(:user)
    @user2 = Factory(:user, :email => Factory.next(:email))    
    @user3 = Factory(:user, :email => Factory.next(:email))    
    @ids = []
    @ids.push(@user2.id)
    @ids.push(@user3.id)
    @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}  
    @message = Message.create!(@attr)
    @reply_attr ={:message_id => @message.id, :content => @message.content}
  end
  it "should create a new instance given valid attributes" do
     @user2.replies.create!(@reply_attr)
  end  
  
  describe "user associations" do  
    before(:each) do
      @reply = @user2.replies.create(@reply_attr)
    end 
    it "should have a user attribute" do
       @reply.should respond_to(:user)
    end 
    it "should have the right associated user"  do
      @reply.user_id.should == @user2.id
      @reply.user.should == @user2
    end  
  end
  
  describe "message associations" do  
    before(:each) do
      @reply = @user2.replies.create(@reply_attr)
    end 
    it "should have a user attribute" do
       @reply.should respond_to(:message)
    end 
    it "should have the right associated user"  do
      @reply.message_id.should == @message.id
      @reply.message.should == @message
    end  
  end
  
  describe "validations" do  
    it "should require a user id" do   
      Reply.new(@reply_attr).should_not be_valid
    end
    it "should require a message id" do
      @user2.replies.build(@reply_attr.merge(:message_id=> "")).should_not be_valid
    end
    it "should reject long content (max: 3000 characters)" do
      @user2.replies.build(@reply_attr.merge(:content=> "t" *3001)).should_not be_valid
    end
    it "should require a content" do
      @user2.replies.build(@reply_attr.merge(:content => "  ")).should_not be_valid
    end  
  end  
end