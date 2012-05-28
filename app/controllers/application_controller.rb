class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :session_counter, :notification_mini ,:facebook_auth
  
  def notification_mini
    if user_signed_in?
      @notifications_mini = current_user.notifications.first(5)
    end
  end

  def facebook_auth 
    if user_signed_in? and current_user.authentications.where(:provider => "facebook").any?
      @oauth = Koala::Facebook::OAuth.new('181566241883873', 'b1d48ecdec1256fa93580ed33895d353')
      facebook_auth = current_user.authentications.where(:provider => "facebook")
      @graph = Koala::Facebook::API.new(facebook_auth.first.token)     
    else
      @graph = nil
    end
  end
            
  def session_counter
    if session[:visit_counter]
      session[:visit_counter] += 1
    else
      session[:visit_counter] = 0
    end
  end 
end
