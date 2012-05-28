require 'spec_helper'

describe Photo do
  before(:each) do
    @user = Factory(:user)
    @attr = {:photoable_id => @user.id, :photoable_type => "User",:image_file_name => "IVISUAL TALK TOUR 2011_ONOFFMIX",:image_content_type => "image" ,:image_file_size => 2 }
    
  end
  it "should create a new instance given valid attributes" do
    @user.authored_photos.create!(@attr)   
  end  
  
  describe "user associations" do  
    before(:each) do
     @photo = @user.authored_photos.create!(@attr)   
    end 
    it "should have a user attribute" do
      @photo.should respond_to(:user)
    end 
    it "should have the right associated user"  do
     @photo.user_id.should == @user.id
     @photo.user.should == @user
    end  
  end
  
  describe "validations" do  
    it "should require a user id" do   
      Photo.new(@attr).should_not be_valid
    end
    it "should require a image_file_name" do
      @user.authored_photos.build(@attr.merge(:image_file_name=> "")).should_not be_valid
    end
    it "should require a image_content_type" do
      @user.authored_photos.build(@attr.merge(:image_content_type=> "")).should_not be_valid
    end
    it "should require a image_file_size" do
      @user.authored_photos.build(@attr.merge(:image_file_size=> "")).should_not be_valid
    end
    it "should require a photoable_id" do
      @user.authored_photos.build(@attr.merge(:photoable_id=> "")).should_not be_valid
    end
    it "should require a photoable_type" do
      @user.authored_photos.build(@attr.merge(:photoable_type=> "")).should_not be_valid
    end
    it "should reject big size (max: 5.megabytes)" do
      @user.authored_photos.build(@attr.merge(:image_file_size=> 600000000)).should_not be_valid
    end
    it "should reject wront content type" do
      @user.authored_photos.build(@attr.merge(:image_content_type => "test")).should_not be_valid
    end  
  end
    
    

end
