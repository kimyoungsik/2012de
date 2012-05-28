# #encoding:UTF-8
# require "spec_helper"
# 
# describe "user registration" do
#   it "allows new users to register with an email address and password" do
#     visit "/d/users/sign_up"
#     fill_in "Email",                 :with => "doly10@headflow.net"
#     fill_in "Password",              :with => "dudtlr"
#     fill_in "Password confirmation", :with => "dudtlr"
#     click_button "Sign up"
#     page.should have_content("성공적으로 가입했습니다.활성화되었다면 확인 메일이 보내집니다.")
#   end
# end