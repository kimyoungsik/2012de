#encoding:UTF-8
require 'spec_helper'

describe Kit do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content", :kitable_id => @user.id, :kitable_type => "User" }
  end 
  it "should create a new instance given valid attributes" do
    @user.authored_kits.create!(@attr)
  end
    
  describe "user associations" do   
    before(:each) do
      @kit = @user.authored_kits.create(@attr)
    end   
    it "should have a user attribute" do
      @kit.should respond_to(:user)
    end  
    it "should have the right associated user" do
      @kit.user_id.should == @user.id
      @kit.user.should == @user
    end  
  end
   
  describe "kitable associations" do  
    before(:each) do
      @kit = @user.authored_kits.create(@attr)
    end  
    it "should have a kitable attribute" do
      @kit.should respond_to(:kitable_id)
    end
     
    describe "for user" do    
      it "should have the right associated kitable" do
        @kit.kitable_id == @user.id
        @kit.kitable_type == "User"
      end 
    end
    
    describe "for seed" do
      it "should have the right associated kitable" do
        @seed = Factory(:seed, :user=>@user)
        @seed_kit = @user.authored_kits.create(@attr.merge(:kitable_id => @seed.id, :kitable_type => "Seed"))
        @seed_kit.kitable_id == @seed.id
        @seed_kit.kitable_type == "Seed"
      end
    end
    
    describe "for network" do 
      it "should have the right associated kitable" do
        @network = Factory(:network)
        @network_kit = @user.authored_kits.create(@attr.merge(:kitable_id => @network.id, :kitable_type => "Network"))
        @network_kit.kitable_id == @network.id
        @network_kit.kitable_type =="Network"
      end
    end
  end
  
  describe "comment associations" do  
    before(:each) do
      @kit = @user.authored_kits.create(@attr)
      @comment = @user.comments.create!(:kit_id => @kit.id, :content => "foobar")
    end  
    it "should have a comment attribute" do
      @kit.should respond_to(:comments)
    end   
    it "should have the right associated comment" do
      @kit.should == @comment.kit
      @kit.id == @comment.kit_id
    end
    it "should destroy associated supports" do
      @kit.destroy
      Comment.find_by_kit_id(@kit.id).should be_nil
    end
  end
   
  describe "ditto associations" do
    before(:each) do
      @kit = @user.authored_kits.create(@attr)
      @ditto = @user.dittos.create!(:dittoable_id => @kit.id, :dittoable_type => "Kit")
    end  
    it "should have a ditto attribute" do
      @kit.should respond_to(:dittos)
    end 
    it "should have the right associated ditto" do
      @ditto.dittoable_type == "Kit"
      @kit.id == @ditto.dittoable_id
      @kit == @ditto.dittoable
    end
    it "should destroy associated dittos" do
      @kit.destroy
      Ditto.find_by_dittoable_id_and_dittoable_type(@kit.id,"Kit").should be_nil
    end  
  end
  
  describe "validations" do
    it "should require a user id" do
      Kit.new(@attr).should_not be_valid
    end
    it "should require nonblank content" do
      @user.authored_kits.build(@attr.merge(:content => "   ")).should_not be_valid
    end
    it "should reject long content (max: 3000 characters)" do
      @user.authored_kits.build(@attr.merge(:content => "t" * 3001)).should_not be_valid
    end 
    it "should require a kitable id" do
      @user.authored_kits.build(@attr.merge(:kitable_id => " ")).should_not be_valid
    end
    it "should require a kitable type" do
      @user.authored_kits.build(@attr.merge(:kitable_type => " ")).should_not be_valid
    end  
    it "should reject a wrong kitable type" do
      @user.authored_kits.build(@attr.merge(:kitable_type => "test")).should_not be_valid    
    end   
  end
end
