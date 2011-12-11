class LostAndFoundItemsController < ApplicationController
  attr_reader :lfis, :lfi
  
  def searchform
  end

  def search
    categories = build_categories_from_params
    like = process_keywords( params[:keywords] )  
            
    @lfis = LostAndFoundItem.where returned: false
    @lfis = @lfis.where( like ) unless like == ''
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

  def mark_found
    @lfi = LostAndFoundItem.find( params[:id] )
    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @lfi }
    end
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

  def process_search_all( keywords )
    like = ''
    keywords.each do |k|
      like += "%#{k}%"
    end
    like = "\"description\" LIKE '#{like}'"
  end

  def process_search_any( keywords )
    like = ''
    keywords.each do |k|
      if k == keywords.first
        like = "\"description\" LIKE '%#{k}%'"
      else
        like += " OR \"description\" LIKE '%#{k}%'"
      end
    end
    return like
  end

  def process_keywords( keyword_params )
    like = ""
    
    if params.has_key? :keywords and params[:keywords] != ''
      keywords = params[:keywords].split

      if params[:search_type] == 'all'
        like = process_search_all( keywords )
      elsif params[:search_type] == 'any'
        like = process_search_any( keywords )
      end
    end    
    
    return like
  end


end
