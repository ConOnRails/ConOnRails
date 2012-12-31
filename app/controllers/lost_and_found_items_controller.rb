class LostAndFoundItemsController < ApplicationController
  before_filter :user_can_add_lost_and_found, only: [:new, :create]
  before_filter :user_can_modify_lost_and_found, only: [:edit, :update]
  attr_reader :lfis, :lfi

  protected

  def user_can_add_lost_and_found
    user = User.find session[:user_id]
    unless user.add_lost_and_found?
      redirect_to lost_and_found_url
    end
  end

  def user_can_modify_lost_and_found
    user = User.find session[:user_id]
    unless user.modify_lost_and_found?
      redirect_to lost_and_found_url
    end
  end

  public

  def searchform
  end

  def search
    categories = build_categories_from_params
    like       = process_keywords(params[:keywords])

    @lfis = LostAndFoundItem.page params[:page]

    # HACK this should be a separate function eventually
    if params[:id].present?
      @lfi = LostAndFoundItem.find_by_id(params[:id])
      return redirect_to lost_and_found_item_path(@lfi) if @lfi.present?
    end

    @lfis = @lfis.where { returned == false } unless params[:show_returned].present? && params[:show_returned] == true
    @lfis = @lfis.where { description.like_any my { params[:keywords].split.collect { |s| "%#{s}%"} } } if params[:search_type] == 'any' unless params[:keywords].blank?
    @lfis = @lfis.where { description.like_all my { params[:keywords].split.collect { |s| "%#{s}%"} } } if params[:search_type] == 'all' unless params[:keywords].blank?
    @lfis = @lfis.where { category >> my { categories }  } unless categories == []

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @lfis }
    end
  end

  def open_inventory
    @lfis = LostAndFoundItem.page params[:page]
    @lfis = @lfis.where found: true, returned: false

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @lfis }
    end

  end

  def new
    @lfi                  = LostAndFoundItem.new
    @lfi.reported_missing = params[:reported_missing]
    @lfi.found            = params[:found]
  end

  def index
  end

  def show
    @lfi = LostAndFoundItem.find(params[:id])
  end

  def create
    @lfi          = LostAndFoundItem.new params[:lost_and_found_item]
    @lfi.user     = current_user
    @lfi.rolename = current_role

    respond_to do |format|
      if @lfi.save
        type = "Missing" if @lfi.reported_missing?
        type = "Found" if @lfi.found?
        format.html { redirect_to @lfi, notice: "#{type} item was successfully created." }
        format.json { render json: @lfi, status: :created, location: @lfi }
      else
        format.html { render action: "edit", lfi: @lfi }
        format.json { render json: @lfi.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @lfi = LostAndFoundItem.find params[:id]
    @lfi.found = true if params[:found] == 'true'
    @lfi.returned = true if params[:returned] =='true'
  end

  def update
    @lfi          = LostAndFoundItem.find params[:id]
    @lfi.user     = current_user
    @lfi.rolename = current_role

    respond_to do |format|
      if @lfi.update_attributes params[:lost_and_found_item]
        type = "Missing" if @lfi.reported_missing?
        type = "Found" if @lfi.found?
        type = "Returned" if @lfi.returned?
        format.html { redirect_to @lfi, notice: "#{type} item was successfully updated." }
        format.json { render json: @lfi, status: :created, location: @lfi }
      else
        format.html { render action: "edit", lfi: @lfi, notide: "#{type} could not be saved." }
        format.json { render json: @lfi.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def build_categories_from_params
    ret = []

    LostAndFoundItem.categories.each do |k, v|
      ks = k.to_s
      ret << v if params.has_key? ks
    end

    return ret
  end

  def process_search_all(keywords)
    ["\"description\" LIKE ?", keywords.inject('') { |like, k|
      like += "%#{k}%" }
    ]
  end

  def process_search_any(keywords)
    like  = []
    query = 'description LIKE ?'
    keywords.each do |k|
      like << "%#{k}%"
      unless k == keywords.first
        query += " OR \"description\" LIKE ?"
      end
    end
    [query].concat like
  end

  def process_keywords(keyword_params)
    like = ""

    if params.has_key? :keywords and params[:keywords] != ''
      keywords = params[:keywords].split

      if params[:search_type] == 'all'
        like = process_search_all(keywords)
      elsif params[:search_type] == 'any'
        like = process_search_any(keywords)
      end
    end

    return like
  end


end
