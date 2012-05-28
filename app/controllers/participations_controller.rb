# encoding: UTF-8
class ParticipationsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @participation = current_user.participations.build(params[:participation])
    @seed = @participation.seed
    if @participation.save

      if Authentication.have_facebook_id(current_user)
        @graph.put_wall_post("새로운 꿈에 도전했습니다. 응원의 킷(Kit)을 남겨주세요.", {
          :name => @seed.title, 
          :picture => request.protocol + request.host + @seed.user.avatar.url,
          :link => request.protocol + request.host + seed_path(@seed),
          :caption => @seed.user.name,
          :description => @seed.description })
      end    

      respond_to do |format|
        format.html { redirect_to @seed}
        format.js
      end
    else 
      redirect_to @seed
    end 
  end
  
  def update
    @participation = Participation.find(params[:id])
    @seed = @participation.seed
    if @participation.update_attributes(:status => "complete")

      if Authentication.have_facebook_id(current_user)
        @graph.put_wall_post("꿈이 이루어졌습니다. 축하해주세요!", {
          :name => @seed.title, 
          :picture => request.protocol + request.host + @seed.user.avatar.url,
          :link => request.protocol + request.host + seed_path(@seed),
          :caption => @seed.user.name,
          :description => @seed.description })
      end

      respond_to do |format|
        format.html { redirect_to @seed}
        format.js
      end
    else
      redirect_to @seed
    end
  end  
  
  def destroy
    @participation = Participation.find(params[:id])       
    @seed = @participation.seed
    if @participation.destroy
      respond_to do |format|
        format.html { redirect_to @seed }
        format.js
      end
    else
      redirect_to seed_path(@seed)
    end
  end
end
