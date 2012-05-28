class SupportsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @support = current_user.supports.build(params[:support])
    @seed = @support.seed
    if @support.save
      respond_to do |format|
        format.html { redirect_to @seed }
        format.js
      end
    else 
      redirect_to @seed
    end
  end
end
