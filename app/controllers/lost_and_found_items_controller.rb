class LostAndFoundItemsController < ApplicationController
  attr_reader :lfis
  
  def searchform
  end

  def search
    categories = build_categories_from_params
    keywords = []
    
    if params.has_key? :keywords and params[:keywords] != ''
      keywords = params[:keywords].split
    end
    
    p keywords
    p params[:search_type]
    
    like = ""
    if params[:search_type] == 'all'
      keywords.each do |k|
        like += "%#{k}%"
      end
      like = "\"description\" LIKE '#{like}'"
    elsif params[:search_type] == 'any'
      keywords.each do |k|
        if k == keywords.first
          like = "\"description\" LIKE '%#{k}%'"
        else
          like += " OR \"description\" LIKE '%#{k}%'"
        end
      end
    end
    
    p like
          
    @lfis = LostAndFoundItem.where returned: false
    @lfis = @lfis.where( like ) 
    @lfis = @lfis.where( category: categories ) unless categories == []
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @lfis } 
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
