class LostAndFoundItemsController < ApplicationController
  attr_reader :lfis, :lfi

  before_filter :user_can_add_lost_and_found, only: [:new, :create]
  before_filter :user_can_modify_lost_and_found, only: [:edit, :update]
  before_filter :build_categories_from_params, only: [:search]

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
    return jump if params[:id].present?
    @lfis = LostAndFoundItem.page params[:page]

    @lfis = @lfis.where { returned == false } unless params[:show_returned].present? && params[:show_returned]# == true
    @lfis = @lfis.where { description.like_any my { wrap_keywords_for_like } } if params[:search_type] == 'any' unless params[:keywords].blank?
    @lfis = @lfis.where { description.like_all my { wrap_keywords_for_like } } if params[:search_type] == 'all' unless params[:keywords].blank?
    @lfis = @lfis.where { category >> my { @categories } } unless @categories.blank?

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @lfis }
    end
  end

  def open_inventory
    @lfis = LostAndFoundItem.inventory.page params[:page]

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
        format.html { redirect_to @lfi, notice: "#{@lfi.Type} item was successfully created." }
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
        type = "Returned" if @lfi.returned?
        format.html { redirect_to @lfi, notice: "#{@lfi.Type} item was successfully updated." }
        format.json { render json: @lfi, status: :created, location: @lfi }
      else
        format.html { render action: "edit", lfi: @lfi, notide: "#{type} could not be saved." }
        format.json { render json: @lfi.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
  def jump
    @lfi = LostAndFoundItem.find_by_id(params[:id])
    return redirect_to lost_and_found_item_path(@lfi) if @lfi.present?
    render 'invalid'
  end

  def wrap_keywords_for_like
    params[:keywords].split.collect { |s| "%#{s}%" }
  end

  private

  def build_categories_from_params
    @categories ||= (LostAndFoundItem.categories.collect do |k, v|
      next unless params.has_key? k.to_s
      v
    end).compact
  end

end
