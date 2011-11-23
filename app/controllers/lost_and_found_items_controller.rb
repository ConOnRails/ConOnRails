class LostAndFoundItemsController < ApplicationController
  def searchform
  end

  def search
    categories = build_categories_from_params
    
    @lfis = LostAndFoundItem.where returned: false
    @lfis = @lfis.where( "description LIKE ?", params[:keywords] ) if params.has_key? :keywords and params[:keywords] != ''
    @lfis = @lfis.where( category: categories ) unless categories == []
    
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
    @lfi = LostAndFoundItem.find(params[:id])
  end


  def create
  end

  def edit
  end

  def update
  end
  
  private
  
  def build_categories_from_params
    ret = []

    LostAndFoundItem.Categories.each do |k, v|
      ks = k.to_s
      ret << v if params.has_key? ks 
    end
    
    return ret
  end
end
