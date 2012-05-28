#encoding:UTF-8
require 'spec_helper'

describe Message do
  
  before(:each) do
    @user = Factory(:user)
    @user2 = Factory(:user, :email => Factory.next(:email))    
    @user3 = Factory(:user, :email => Factory.next(:email))    
    @ids = []
    @ids.push(@user2.id)
    @ids.push(@user3.id)
    @attr = {:title => "dreamkit!", :content => "become a dreamer",:participant_ids => @ids}
  end
  it "should create a new instance given valid attributes" do
    @message = Message.new(@attr)
    @message.save
  end
  
  describe "paticipant associations" do
    before(:each) do
      @message = Message.new(@attr)
      @message.save
      @reply = @user.replies.create!(:message_id => @message.id, :content => @message.content)
      @user.message_participations.create!(:message_id => @message.id)
      @message.participant_ids.each do |id|
        User.find(id).message_participations.create!(:message_id => @message.id)
      end
    end
    it "should have the right associated paticipant" do
      @message.participant_ids.should == @ids
    end
  end
  
  describe "reply associations" do
    before(:each) do
      @message = Message.new(@attr)
      @message.save
      @reply = @user.replies.create!(:message_id => @message.id, :content => @message.content)
    end
    it "should have a replies attribute" do
      @message.should respond_to(:replies)
    end
  end
  
  describe "validations" do
    it "should require nonblank content" do
      @message = Message.create(@attr.merge(:content => "   ")).should_not be_valid
    end
    it "should require nonblank title" do
      @message = Message.create(@attr.merge(:title => "   ")).should_not be_valid
    end    
    it "should reject long content (max: 10000 characters)" do
      @message = Message.create(@attr.merge(:content => "t" * 10001)).should_not be_valid
    end
    it "should reject long content (max: 140 characters)" do
      @message = Message.create(@attr.merge(:title => "t" * 141)).should_not be_valid
    end       
  end  
end