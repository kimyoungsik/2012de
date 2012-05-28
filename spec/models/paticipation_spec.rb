#encoding:UTF-8
require 'spec_helper'

describe Participation do
  
  before(:each) do
    @user = Factory(:user)
    @another_user = Factory(:user, :email => Factory.next(:email))
    @seed = Factory(:seed, :user => @user)
    @attr = {:seed_id => @seed.id, :status=> "progress"}
  end
  
  it "should create a new instance given valid attributes" do
     @another_user.participations.create!(@attr)
  end
  
  describe "user associations" do   
    before(:each) do
     @participation = @another_user.participations.create!(@attr)
    end   
    it "should have a user attribute" do
     @participation.should respond_to(:user)
    end  
    it "should have the right associated user" do
     @participation.user_id.should == @another_user.id
     @participation.user.should == @another_user
    end  
  end
  
  describe "seed associations" do   
    before(:each) do
     @participation = @another_user.participations.create!(@attr)
    end   
    it "should have a user attribute" do
     @participation.should respond_to(:seed)
    end  
    it "should have the right associated user" do
     @participation.seed_id.should == @seed.id
     @participation.seed.should == @seed
    end  
  end
  
  describe "validations" do  
    it "should require a user id" do   
      Participation.new(@attr).should_not be_valid
    end
    it "should require a seed_id" do
      @another_user.participations.build(@attr.merge(:seed_id=> "")).should_not be_valid
    end
    it "should require right status" do
      @another_user.participations.build(@attr.merge(:status=> "test")).should_not be_valid
    end    
  end    
end