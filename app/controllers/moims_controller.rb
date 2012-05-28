class MoimsController < ApplicationController
  def index
    @moims = Moim.all
  end

  def new
  end

  def show
    @moim = Moim.find(params[:id])
  end

end
