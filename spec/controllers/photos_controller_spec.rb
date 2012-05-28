require 'spec_helper'

describe PhotosController do
  
	describe "access control" do
  	it "should deny create"do
			post :index
			response.should redirect_to(root_path)
		end
		it "should deny create"do
			post :new
			response.should redirect_to(root_path)
		end	
		it "should deny create"do
			post :create
			response.should redirect_to(root_path)
		end	
  	it "should deny create"do
			post :edit
			response.should redirect_to(root_path)
		end
	end
	
	describe "POST 'create'" do 
    before(:each) do
      @user = test_sign_in(Factory(:user))    
    end
    
    describe "success" do
      before(:each) do
        @attr = {:photoable_id => @user.id, :photoable_type => "User",:image_file_name => "IVISUAL TALK TOUR 2011_ONOFFMIX",:image_content_type => "image" ,:image_file_size => 2 }
      end
      it "should create a photo" do
        lambda do
          post :create, :photo => @attr
        end.should change(Photo, :count).by(1)
      end
    end

    describe "failure" do
      before(:each) do
        @attr = {:photoable_id => @user.id, :photoable_type => "A",:image_file_name => "",:image_content_type => "jpg" ,:image_file_size => 3 }
      end
      it "should not create a photo" do
        lambda do
          post :create, :photo => @attr
        end.should_not change(Photo, :count)
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))  
      @attr = {:photoable_id => @user.id, :photoable_type => "User",:image_file_name => "IVISUAL TALK TOUR 2011_ONOFFMIX",:image_content_type => "image" ,:image_file_size => 2 }
      @photo = @user.authored_photos.build(@attr)
      @photo.save 
    end
       
    describe "success" do   
      before(:each) do
        @update_attr = {:photoable_id => @user.id, :photoable_type => "User",:image_file_name => "TOUR 2011_ONOFFMIX",:image_content_type => "image" ,:image_file_size => 3 }
      end
      it "should change the seed's attributes"do
        put :update, :id => @photo, :photo => @update_attr
        @photo.reload
        @photo.image_file_name == @update_attr[:image_file_name]
        @photo.image_content_type == @update_attr[:image_content_type]
      end
      it "should redirect to the seed show page" do
        put :update, :id => @photo, :photo => @update_attr
        response.should redirect_to(user_path(@user))
      end
    end
    
    describe "failure" do   
      before(:each) do
        @update_attr = {:photoable_id => @user.id, :photoable_type => "User",:image_file_name => "",:image_content_type => "image" ,:image_file_size => 3 }
      end
      it "should render the 'edit' page"do 
        put :update, :id => @photo, :photo => @update_attr
        response.should render_template('edit')
      end
    end   
  end
end
