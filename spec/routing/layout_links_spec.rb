#encoding:UTF-8
require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "시드 | DreamKit")
  end
  it "should have a Contact page at '/kits'" do
    get '/kits'
    response.should have_selector('title', :content => "시내 | DreamKit")
  end
  it "should have an About page at '/networks'" do
    get '/networks'
    response.should have_selector('title', :content => "사람들 | DreamKit")
  end
  it "should have the right links on the layout" do
     visit root_path
     click_link "시내"
     response.should have_selector('title', :content => "시내 | DreamKit")
     click_link "사람들"
     response.should have_selector('title', :content => "사람들 | DreamKit")
   end
end