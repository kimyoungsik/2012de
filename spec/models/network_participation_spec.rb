
#encoding:UTF-8
require 'spec_helper'

describe NetworkParticipation do

  before(:each) do
    @user = Factory(:user)
    @network = Factory(:network)
    # @network_participation = Factory(:network_participation, :user => @user, :network => @network)
  end

  it "should create a new instance given valid attributes" do
     @network_participation = NetworkParticipation.new(:user => @user, :network => @network)
     @network_participation.save
  end
  
  describe "user associations" do   
    before(:each) do
     @network_participation = NetworkParticipation.new(:user => @user, :network => @network)
     @network_participation.save
    end   
    it "should have a user attribute" do
     @network_participation.should respond_to(:user)
    end  
    it "should have the right associated user" do
     @network_participation.user_id.should == @user.id
     @network_participation.user.should == @user
    end  
  end  
  
  describe "network associations" do   
    before(:each) do
     @network_participation = NetworkParticipation.new(:user => @user, :network => @network)
     @network_participation.save
    end   
    it "should have a network attribute" do
     @network_participation.should respond_to(:network)
    end  
    it "should have the right associated network" do
     @network_participation.network_id.should == @network.id
     @network_participation.network.should == @network
    end  
  end
  
  describe "validations" do
    it "should require a user id" do
      NetworkParticipation.new(:network => @network).should_not be_valid
    end
    it "should require a network id" do
      NetworkParticipation.new(:user => @user).should_not be_valid
    end
  end
end