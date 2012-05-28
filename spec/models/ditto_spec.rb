#encoding:UTF-8
require 'spec_helper'

describe Ditto do
  before(:each) do
     @user = Factory(:user)
     @kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @user.id, :kitable_type => "User")
     @attr = {:dittoable_id => @kit.id, :dittoable_type => "Kit"}
   end
   
   it "should create a new instance given valid attributes" do
     @user.dittos.create!(@attr)
   end
    
   describe "user association" do   
     before (:each) do
       @ditto = @user.dittos.create!(@attr)
     end
     it "should have a user attribute" do
       @ditto.should respond_to(:user)
     end
     it "should have the right associated user" do
       @ditto.user.should == @user
       @ditto.user_id.should == @user.id  
     end
   end
   
   describe "dittoable associaton" do  
     before(:each) do
        @ditto = @user.dittos.create!(@attr)
     end   
     it "should have the a dittoable attribute" do
        @ditto.should respond_to(:dittoable_id)
     end   
     describe "for kit" do  
       it "should have the right attributed dittoable" do
         @ditto.dittoable_id == @kit.id
         @ditto.dittoable_type == "Kit"
       end
     end
     describe "when dittoable_type is comment "do
       before(:each) do
         @comment = Factory(:comment ,:user =>@user, :kit =>@kit)      
         @ditto =@user.dittos.create(@attr.merge(:dittoable_id => @comment.id, :dittoable_type => "Comment"))
       end 
       it "should have the right attributed dittoable" do
         @ditto.dittoable_id== @comment.id
         @ditto.dittoable_type == "Comment"
       end
     end 
   end
   
   describe "validation" do    
     it"should require a user id" do       
        Ditto.new(@attr).should_not be_valid  
     end   
     it "should require a dittoable id" do
       @user.dittos.build(@attr.merge(:dittoable_id =>"")).should_not be_valid
     end 
     it "should require a dittoable type" do
       @user.dittos.build(@attr.merge(:dittoable_type=>"")).should_not be_valid
     end    
     it "should reject a wrong dittoable type" do
       @user.dittos.build(@attr.merge(:dittoable_type=>"test")).should_not be_valid
     end
   end
end
