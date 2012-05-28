# encoding: UTF-8
class SeedsController < ApplicationController

  before_filter :authorized_user, :only => [:destroy, :edit, :update]
  before_filter :authenticate_user!, :except =>[:index, :show]
  # before_filter :facebook_auth, :only => [:create]

  def index
    @title ="DreamKit | 꿈이 현실이 되는 공간"
    @description ="혼자 꾸는 꿈은 꿈일 뿐이지만, 함께 꾸는 꿈은 현실이 된다. 다양한 꿈을 가진 사람들과 함께 계획하고 실천하는 공간. 누구나 이루고 싶은 목표를 시드로 만들어 공유-참여-응원하여 모두의 꿈을 실현하는 열린 커뮤니티"
    @revisit_after = "1 days"
    if params[:search]
      @search = Seed.search do
        fulltext params[:search]
        paginate(:page => params[:page], :per_page => 20)
      end
      @seeds = @search.results
    else
      @seeds = Seed.order("id").page(params[:page]).per_page(20)
    end
    @seed = Seed.new
  end
  
  def create
    @seed = current_user.seeds.build(params[:seed])
    if @seed.save
      if Authentication.have_facebook_id(current_user)
        @graph.put_wall_post("드림킷에 새로운 꿈 시드를 심었습니다. 함께 참여해보세요.", {
          :name => @seed.title, 
          :picture => request.protocol + request.host + @seed.user.avatar.url,
          :link => request.protocol + request.host + seed_path(@seed),
          :caption => @seed.user.name,
          :description => @seed.description })
        end
      respond_to do |format|
        format.html { redirect_to @seed }
      end      
    else
      render :new
    end
  end
  
  def show
    @seed = Seed.find(params[:id])
    @title = @seed.title
    @description = @seed.description
    @author = @seed.user.name
    @kits = @seed.kits.page(params[:page]).per_page(10)
    @kit = @seed.kits.build
  end
  
  def edit
    @seed = Seed.find(params[:id])
    render 'seeds/edit'
  end
  
  def update
     @seed = Seed.find(params[:id])
     if @seed.update_attributes(params[:seed])
       redirect_to seed_path(@seed)
     else
       render 'edit'
     end
  end
  
  def destroy
   
    @seed = Seed.find(params[:id])
    @seed.destroy
    redirect_back_or seeds_path  
  end
  
  private

  def authorized_user
    @seed = Seed.find(params[:id])
    redirect_to seeds_path unless current_user == @seed.user
  end

  def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     clear_return_to
  end

  def clear_return_to
      session[:return_to] = nil
  end
  
end
 

