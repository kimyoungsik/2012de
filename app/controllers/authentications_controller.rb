class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    # render :text => request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
    data = request.env["omniauth.auth"].extra.raw_info
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      if authentication.provider == "facebook"
        authentication.token = omniauth['credentials']['token']
        authentication.save!
      end
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new(:email => data.email, 
                      :name => data.last_name + " " + data.first_name, 
                      :birthday => Date::strptime(data.birthday, "%m/%d/%Y"),
                      :sex => data.gender,
                      :password => Devise.friendly_token[0,20])
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      elsif User.find_by_email(data.email)
        session[:omniauth_email] = data.email
        redirect_to new_user_password_path
      # else
      #   session[:omniauth] = omniauth.except('extra')
      #   redirect_to new_user_registration_path
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
