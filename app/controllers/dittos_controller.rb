class DittosController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :authorized_user, :only => :destroy
  
  def create
    @ditto = current_user.dittos.build(params[:ditto])
    @ditto.save 
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @ditto = Ditto.find(params[:id])
    @ditto.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def authorized_user
     @ditto = Ditto.find(params[:id])
     redirect_to kits_path unless current_user == @ditto.user
   end
  
end
