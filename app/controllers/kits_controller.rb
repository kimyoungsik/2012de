# encoding: UTF-8
class KitsController < ApplicationController
before_filter :authenticate_user!, :except =>[:index]
before_filter :authorized_user, :only => [:destroy]
  def index
    @title = "시내 | 이야기로 성장하는 네트워크"
    @description ="강연, 스터디, 여행, 독서, 연애, 취업 - 매일 매일 참여하고 공유하며 서로 성장하는 응원과 이야기들"
    @revisit_after = "1 days"
    if user_signed_in?
      @kit = current_user.kits.build
    end
    if params[:search]
      @search = Kit.search do
        fulltext params[:search]
        paginate(:page => params[:page], :per_page => 20)
      end
      @kits = @search.results
    else
      @kits = Kit.order("id").page(params[:page]).per_page(20)
    end
  end

  def create
    @kit = current_user.authored_kits.build(params[:kit])

    if @kit.save 
      if @kit.kitable_type == "Seed" 
        @seed = @kit.kitable
        @seed.updated_at = Time.now
        @seed.save
      end      
  
      if @kit.kitable_type == "User" and @kit.user_id != @kit.kitable.id
        Notification.notify(@kit.kitable.id, "kit_notification", @kit.id, "Kit", current_user.id)
      elsif @kit.kitable_type == "Seed" and @kit.user_id != @kit.kitable.user.id
        Notification.notify(@kit.kitable.user.id, "seed_kit_notification", @kit.id, "Kit", current_user.id)
      end
    end
 
    respond_to do |format|
      format.html { redirect_back_or kits_path }
      format.js
    end
    
  end
  
  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy
    respond_to do |format|
        format.html { redirect_back_or kits_path }
        format.js
    end
  end
  
  
  def view_all_comments
    @kit = Kit.find(params[:id])
    respond_to do |format|
      format.js
    end    
  end
  
  
  private
  
  def authorized_user
     @kit = Kit.find(params[:id])
     redirect_to kits_path unless current_user == @kit.user
   end
   
  def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     clear_return_to
  end

  def clear_return_to
      session[:return_to] = nil
  end
  
end
