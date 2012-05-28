class NotificationSettingsController < ApplicationController
  # POST /notification_settings
  # POST /notification_settings.xml
  
  # before_filter :authenticate_user!
  def create
    @notification_setting = NotificationSetting.new(params[:notification_setting])
    
    respond_to do |format|
      if @notification_setting.save
        format.html { redirect_to(edit_user_path(current_user)) }
      else
        format.html { redirect_to(edit_user_path(current_user)) }
      end
    end
  end

  # PUT /notification_settings/1
  # PUT /notification_settings/1.xml
  def update
    @notification_setting = NotificationSetting.find(params[:id])

    respond_to do |format|
      if @notification_setting.update_attributes(params[:notification_setting])
        format.html { redirect_to(edit_user_registration_path) }
      else
        format.html { redirect_to(edit_user_registration_path) }
      end
    end
  end

  # DELETE /notification_settings/1
  # DELETE /notification_settings/1.xml
  def destroy
    @notification_setting = NotificationSetting.find(params[:id])
    @notification_setting.destroy

    respond_to do |format|
      format.html { redirect_to(notification_settings_url) }
      format.xml  { head :ok }
    end
  end  
end