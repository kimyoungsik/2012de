# encoding: UTF-8
class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @title ="알림"
    @notifications = current_user.notifications.page(params[:page]).per_page(20)
  end
  
  def reset_count
    current_user.unread_notifications.each do |unread_notification|
      unread_notification.read = true
      unread_notification.save!
    end
    respond_to do |format|
      format.js
    end
  end
end
