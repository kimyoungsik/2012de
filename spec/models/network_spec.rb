#encoding:UTF-8
require 'spec_helper'

describe Network do

  before(:each) do
    @attr = { :name => "headflow", :network_type => "company", :address => "headflow@headflow.net"}
  end
  
  it "should create a new instance given valid attributes" do
     @network = Network.new(@attr)
     @network.save
  end
  
  describe "kit association" do  
    before(:each) do
      @user = Factory(:user)
      @network = Network.new(@attr)
      @network.save
      @kit = @user.authored_kits.create!(:content => "foobar", :kitable_id => @network.id, :kitable_type => "Network")
    end  
    it "should have a kit attribute" do
      @network.should respond_to(:kits)
    end 
    it "should have the right associated kit" do
      @network.id.should == @kit.kitable_id
    end 
    it "should destroy associated kits" do
      @network.destroy
      Kit.find_by_kitable_id_and_kitable_type(@network.id,"Network").should be_nil
    end  
  end
  
  describe "network_participations association" do
    before(:each) do
      @user = Factory(:user)
      @network = Network.new(@attr)
      @network.save
      @network_participation = NetworkParticipation.new(:user => @user, :network => @network)
    end
    it "should have a kit attribute" do
      @network.should respond_to(:network_participations)
    end 
    it "should have the right associated kit" do
      @network.id.should == @network_participation.network_id
    end 
    it "should destroy associated kits" do
      @network.destroy
      NetworkParticipation.find_by_network_id(@network.id).should be_nil
    end 
  end
  
  describe "validations" do 
    it "should require nonblank name" do
      Network.create(@attr.merge(:name => "   ")).should_not be_valid
    end
    it "should require nonblank network_type" do
      Network.create(@attr.merge(:network_type => "   ")).should_not be_valid
    end
    it "should require nonblank address" do
      Network.create(@attr.merge(:address => "   ")).should_not be_valid
    end
  end
end