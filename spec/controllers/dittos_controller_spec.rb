#encoding:UTF-8
require 'spec_helper'

describe DittosController do
	render_views	
	
	describe "access control" do	
		it "should deny create"do
			post :create
			response.should redirect_to(root_path)
		end	
		it "should deny destroy" do
			delete :destroy, :id => 1
			response.should redirect_to(root_path)
		end
	end
	
	describe "POST 'create'" do
		before(:each) do
			@user = test_sign_in(Factory(:user))
			@kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @user.id, :kitable_type => "User")
			@comment = Factory(:comment ,:user =>@user, :kit =>@kit)
		end
	
		describe "failure" do	
			before(:each) do
				@kit_attr = {:dittoable_id => "", :dittoable_type => "Kit"}
				@comment_attr = {:dittoable_id => "", :dittoable_type => "Comment"}				 
			end		
			it "should not create a ditto in kit" do
				lambda do
					post :create, :ditto =>@kit_attr
				end.should_not change(Ditto,:count)			
			end
			it "should not create a ditto in comment" do
				lambda do
					post :create, :ditto =>@comment_attr
				end.should_not change(Ditto,:count)			
			end		
		end
		
		describe "success" do		
			before(:each) do
				@kit_attr = {:dittoable_id => @kit.id ,:dittoable_type => "Kit"}
				@comment_attr = {:dittoable_id => @comment.id, :dittoable_type => "Comment"}				
			end		
			it "should create a ditto in kit" do
				lambda do
					post :create, :ditto =>@kit_attr
				end.should change(Ditto,:count).by(1)
			end
			it "should create a ditto in comment" do
				lambda do
					post :create, :ditto =>@comment_attr
				end.should change(Ditto,:count).by(1)
			end				 
		end
	end
	
	describe "DELETE 'destroy'" do
		before(:each) do
			@user = Factory(:user)
			@kit = @user.authored_kits.create!(:content => "contenttest", :kitable_id => @user.id, :kitable_type => "User")
			@comment = Factory(:comment ,:user =>@user, :kit =>@kit)			
		end	
		describe "destroy a ditto in kit" do		
			before(:each) do
				@kit_ditto = @user.dittos.create!(:dittoable_id => @kit.id, :dittoable_type => "Kit")				 
			end		
			describe "for an unauthorized user" do			 	
				before(:each) do
					@wrong_user = Factory(:user, :email => Factory.next(:email))
					test_sign_in(@wrong_user)
				end					 
				it "should deny destroy" do
					lambda do
						post :destroy, :id => @kit_ditto
					end.should_not change(Ditto,:count)
				end
			end
		
			describe "for an authorized user" do				
				before (:each) do
					test_sign_in(@user)
				end				
				it "should destroy a ditto" do
					 lambda do
						 post :destroy, :id => @kit_ditto
					 end.should change(Ditto,:count).by(-1)
				end							 
			end
		end
		
		describe "destroy a ditto in comment" do	 
			before(:each) do
				@comment_ditto = @user.dittos.create!(:dittoable_id => @comment.id, :dittoable_type => "Comment")				 
			end
			
			describe "for an unauthorized user" do			 
				before(:each) do
					@wrong_user = Factory(:user, :email => Factory.next(:email))
					test_sign_in(@wrong_user)
				end
				it "should deny destroy" do
					lambda do
						post :destroy, :id => @comment_ditto
					end.should_not change(Ditto,:count)
				end
			 end

		  describe "for an authorized user" do				
			  before (:each) do
		  		test_sign_in(@user)
			  end

		  	it "should destroy a ditto" do
				  lambda do
				  	post :destroy, :id => @comment_ditto
				  end.should change(Ditto,:count).by(-1)
			  end							 
		  end 
		end
	end 
end

