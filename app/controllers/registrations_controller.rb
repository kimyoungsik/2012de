class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if user_signed_in? and current_user.notification_setting.nil?
      NotificationSetting.create!(:user_id => current_user.id)
    end
  end
  
  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end