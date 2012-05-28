#encoding:UTF-8
require 'spec_helper'

describe MessageParticipation do
  
  before(:each) do
    @user = Factory(:user)
    @user2 = Factory(:user, :email => Factory.next(:email))    
    @user3 = Factory(:user, :email => Factory.next(:email))    
    @ids = []
    @ids.push(@user2.id)
    @ids.push(@user3.id)
    @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}
    @message = Message.new(@attr)
    @message.save
    @reply = @user.replies.create!(:message_id => @message.id, :content => @message.content)
  end
  it "should create a new instance given valid attributes" do
    @participantion = @user.message_participations.new(:message_id => @message.id)
    @participantion.save
  end
  
  describe "user associations" do   
    before(:each) do
      @paticipantion = @user.message_participations.new(:message_id => @message.id)
      @paticipantion.save
    end   
    it "should have a user attribute" do
      @paticipantion.should respond_to(:user)
    end  
    it "should have the right associated user" do
      @paticipantion.user_id.should == @user.id
      @paticipantion.user.should == @user
    end  
  end
  
  describe "message associations" do
    before(:each) do
      @participantion = @user.message_participations.new(:message_id => @message.id)
      @participantion.save
    end
    it "should have a user attribute" do
      @participantion.should respond_to(:message)
    end  
    it "should have the right associated user" do
      @participantion.message_id.should == @message.id
      @participantion.message.should == @message
    end  
  end
  
  describe "validations" do
    it "should require a user id" do
      MessageParticipation.new(:message_id => @message.id).should_not be_valid
    end
    it "should require nonblank content" do
       @user.message_participations.build(:message_id => "   ").should_not be_valid
    end
  end
end