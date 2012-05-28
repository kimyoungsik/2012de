#encoding:UTF-8
require 'spec_helper'

describe Seed do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :title => "value for title", :description => "value for description"}
  end
  
  it "should create a new instance given valid attributes" do
     @user.seeds.create!(@attr)
   end
  
  describe "user associations" do  
    before(:each) do
      @seed = @user.seeds.create(@attr)
    end 
    it "should have a user attribute" do
       @seed.should respond_to(:user)
    end 
    it "should have the right associated user"  do
      @seed.user_id.should == @user.id
      @seed.user.should == @user
    end  
  end
  
  describe "kit association" do  
    before(:each) do
      @seed = @user.seeds.create!(@attr)
      @kit = @user.authored_kits.create!(:content => "foobar", :kitable_id => @seed.id, :kitable_type => "Seed")
    end  
    it "should have a kit attribute" do
      @seed.should respond_to(:kits)
    end 
    it "should have the right associated kit" do
      @seed.id.should == @kit.kitable_id
    end 
    it "should destroy associated kits" do
      @seed.destroy
      Kit.find_by_kitable_id_and_kitable_type(@seed.id,"Seed").should be_nil
    end  
  end
  
  describe "validations" do  
    it "should require a user id" do   
      Seed.new(@attr).should_not be_valid
    end
    it "should require nonblank title" do
      @user.seeds.build(@attr.merge(:title=> "")).should_not be_valid
    end
    it "should reject long title (max: 140 characters)" do
      @user.seeds.build(@attr.merge(:title=> "t" *141)).should_not be_valid
    end
    it "should require nonblank description" do
      @user.seeds.build(@attr.merge(:description => "  ")).should_not be_valid
    end  
    it "should reject long description (max: 10000 characters)" do
      @user.seeds.build(@attr.merge(:description => "t" * 10001)).should_not be_valid
    end 
  end
end
