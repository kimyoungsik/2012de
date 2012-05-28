#encoding:UTF-8
require 'spec_helper'

describe Comment do  
  before(:each) do
    @user = (Factory(:user))
    @kit = @user.authored_kits.create!(:content => "Foobar", :kitable_id => @user.id, :kitable_type => "User")
    @attr = {:content => "value", :kit_id => @kit}
  end
  it "should create a new instance given valid attributes (@user.commests)" do
    @user.comments.create!(@attr)
  end
  it "should create a new instance given valid attributes (@kit.comments)" do
    @comment = @kit.comments.build
    @comment.user = @user
    @comment.save
  end
  
  describe "kit associations" do
    before(:each) do
      @comment = @kit.comments.build
      @comment.user = @user
      @comment.save
    end  
    it "should have a kit attribute" do
      @comment.should respond_to(:kit)
    end
    it "should have the right associated kit" do
      @comment.kit_id.should == @kit.id
      @comment.kit.should == @kit
    end 
  end

  describe "user associations" do
    before(:each) do
      @comment = @user.comments.create(@attr)
    end
    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end
    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user  
    end
  end

  describe "ditto associations" do 
    before(:each) do
      @comment = @user.comments.create(@attr)
      @ditto = @user.dittos.create!(:dittoable_id => @comment.id, :dittoable_type => "Comment")
    end
    it "should have a ditto attribute" do
      @comment.should respond_to(:dittos)
    end
    it "should have the right associated ditto" do
      @comment.should == @ditto.dittoable
      @comment.id.should == @ditto.dittoable_id
    end 
    it "should destroy aoociated dittos" do
      @comment.destroy
      Ditto.find_by_dittoable_id_and_dittoable_type(@comment.id, "Comment").should be_nil
    end
  end

  describe "validations" do 
    it "should require a user id" do
      Comment.new(@attr).should_not be_valid
    end 
    it "should require nonblank content" do
      @user.comments.build(@attr.merge(:content => " ")).should_not be_valid
    end
    it "should require not too long content (max 3000 characters)" do
      @user.comments.build(@attr.merge(:content => "t"*3001 )).should_not be_valid
    end
    it "should require a kit_id" do
      @user.comments.build(@attr.merge(:kit_id => " ")).should_not be_valid  
    end
  end
end

