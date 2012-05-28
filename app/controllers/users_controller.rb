# encoding: UTF-8
class UsersController < ApplicationController
  before_filter :token_check, :only => [ :import ]
  before_filter :authenticate_user! ,:token_check, :only => [ :friends, :pending_friends, :requested_friends, :import ]
  autocomplete :user, :name
  respond_to :html, :json
  def index
    @title = "사람들"
    @description =""
    @users = User.order("id").page(params[:page]).per_page(20)
    @users_all = User.where("name like ?", "%#{params[:q]}%").select(['id', 'name'])
    respond_to do |format|
      format.json {render :json => @users_all.map(&:attributes) }
    end
  end
  
  def show 
    @user = User.find(params[:id])
    @title = @user.name
    @description =""
    @kits = @user.kits.page(params[:page]).per_page(10)
    @kit = Kit.new(:kitable_id => @user.id, :kitable_type => "User")
    
    if !@user.authentications.where(:provider => "facebook").empty?
      @facebook_uid = @user.authentications.where(:provider => "facebook").last.uid
    end
  end
  
  def friends
    @user = User.find(params[:id])
    @friends = @user.friends.page(params[:page]).per_page(30)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def pending_friends
    @user = User.find(params[:id])
    @pending_friends = @user.pending_friends.page(params[:page]).per_page(30)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def requested_friends
    @user = User.find(params[:id])
    @requested_friends = @user.requested_friends.page(params[:page]).per_page(30)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def import
    @title = "페이스북 친구"
    @description ="페이스북 친구를 드림킷 친구로 추가"
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
    
    respond_to do |format|
       if @user.update_attributes(params[:user])
         format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
         format.json { respond_with_bip(@user) }
       else
         format.html { render :action => "edit" }
         format.json { respond_with_bip(@user) }
       end
    end     
  end
  
  private
  
  def token_check
    redirect_to(root_path) unless Authentication.have_facebook_id(current_user)
  end
end