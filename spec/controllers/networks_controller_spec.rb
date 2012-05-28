#encoding:UTF-8
require 'spec_helper'

describe NetworksController do

	render_views

	describe "GET 'index'" do
		before(:each) do
			@user = test_sign_in(Factory(:user))
			@network = Factory(:network)
			@networks = []
			5.times do 
				@networks << Factory(:network, :name => Factory.next(:name))
			end
			@users =[]
			5.times do
				@users << Factory(:user, :email => Factory.next(:email))
			end
		end
		it "should be successful" do
			get :index
			response.should be_success
		end
		it "should have the right title" do
      get 'index'
      response.should have_selector("title", :content => "사람들 | DreamKit")
    end

		it "should have an element for each network" do
			get :index
			@networks[0..2].each do |network|
				response.should have_selector("div", :content => network.name)
			end
		end
		it "should have some users" do
			get :index
			@users[0..2].each do |user|
				response.should have_selector("div", :content => user.name)
			end
		end
	end
end


		