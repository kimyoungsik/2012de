#encoding:UTF-8
class NetworkParticipationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authorized_user, :only => :destroy

  def create
    @network_participation = current_user.network_participations.build(params[:network_participation])
    if !Network.find_by_name(params[:network_participation][:network_name]).nil?
      @network_participation.network_id = Network.find_by_name(params[:network_participation][:network_name]).id
    end
    respond_to do |format|
      if @network_participation.save
        if Authentication.have_facebook_id(current_user)
          @network = @network_participation.network
          @graph.put_wall_post("드림킷에서 '#{@network.name}' 네트워크에 참여했습니다.", {
            :name => "#{@network.name} 네트워크",
            :description => "총 #{@network.network_participations.count}명의 사람들이 함께하고 있습니다.",
            :picture => "http://www.dreamkit.net/assets/logo.png",
            :link => request.protocol + request.host + network_path(@network)
          })
        end
        format.html { redirect_back_or user_path(current_user) }
        format.js
      else
        flash[:error] = "존재하지 않거나 이미 등록된 네트워크입니다."
        format.html { redirect_back_or user_path(current_user) }
        format.js
      end
    end     
  end

  def destroy
    @network_participation = NetworkParticipation.find(params[:id])    
    if current_user.admin? or (@network_participation.user == current_user)
      @network_participation.destroy
    end
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.js
    end
  end

  private

  def authorized_user
    @network_participation = NetworkParticipation.find(params[:id])
    redirect_to networks_path unless current_user == @network_participation.user
  end
  
  def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     clear_return_to
  end

  def clear_return_to
      session[:return_to] = nil
  end
  

end