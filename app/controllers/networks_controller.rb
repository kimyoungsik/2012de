# encoding: UTF-8
class NetworksController < ApplicationController
  # before_filter :authenticate_user!, :except =>[:index]
  before_filter :search_network
  
  def index
    @title = "사람들 | 함께 꿈을 실현하는 친구들"
    @description ="함께 꾸는 꿈은 현실이 된다. 서로의 관심사와 이야기거리를 발견하고 함께 꿈을 이룰 멘토, 멘티, 친구들을 발견할 수 있는 공간"
    @users = User.order("id").page(params[:page]).per_page(30)
    @networks_all = Network.order(:name).where("name like ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.js
      format.json {render :json => @networks_all.map(&:name) }
    end
  end


  def show
    @network = Network.find(params[:id])
    @title = "#{@network.name} | 다양한 꿈을 공유하는 그룹"
    @description ="내가 속한 학교, 기관, 동아리에서 같은 꿈을 꾸는 사람들을 온라인에서 만날 수 있는 네트워크"
    @revisit_after = "1 days"
    @kit = Kit.new(:kitable_id => @network.id, :kitable_type => "Network")
    @kits = @network.kits.page(params[:page]).per_page(20)
    @network_participants = @network.network_participants.first(20)
  end
  
  def search_network
    if params[:search]
      @search = Network.search do
        fulltext params[:search]
      end
      @networks = @search.results
    else
      @networks = Network.all.first(30)
    end
  end
end
