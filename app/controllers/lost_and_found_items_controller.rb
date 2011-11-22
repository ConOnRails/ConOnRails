class LostAndFoundItemsController < ApplicationController
  def searchform
  end

  def search
    @lfis = LostAndFoundItem.all
    
    respond_to do |format|
      format.html { render "index"}
      format.json { render json: @lfis}
    end    
  end

  def new
    @lfi = LostAndFoundItem.new
    @lfi.reported_missing = params[:reported_missing]
    @lfi.found = params[:found]
  end

  def index
  end

  def show
  end


  def create
  end

  def edit
  end

  def update
  end
end
