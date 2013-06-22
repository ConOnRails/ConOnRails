class LostAndFoundItemsController < ApplicationController
  respond_to :html, :json

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

  def index
    return jump if params[:id].present?
    @lfis = LostAndFoundItem.inventory(params[:inventory]).page params[:page]

    @lfis = @lfis.where { returned == false } unless params[:show_returned].present? && params[:show_returned] # == true
    @lfis = @lfis.where { description.like_any my { wrap_keywords_for_like } } if params[:search_type] == 'any' unless params[:keywords].blank?
    @lfis = @lfis.where { description.like_all my { wrap_keywords_for_like } } if params[:search_type] == 'all' unless params[:keywords].blank?
    @lfis = @lfis.where { category >> my { @categories } } unless @categories.blank?

    respond_with @lfis do |format|
      if @lfis.count == 0
        format.html { redirect_to searchform_lost_and_found_items_path, notice: "Request returned no results" }
      end
    end
  end

  def new
    @lfi                  = LostAndFoundItem.new
    @lfi.reported_missing = params[:reported_missing]
    @lfi.found            = params[:found]
  end

  def show
    @lfi = LostAndFoundItem.find(params[:id])
  end

  def create
    @lfi          = LostAndFoundItem.new params[:lost_and_found_item]
    @lfi.user     = current_user
    @lfi.rolename = current_role

    flash[:notice] = "#{@lfi.Type} item was successfully created." if @lfi.save

    respond_with @lfi
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

    flash[:notice] = "#{@lfi.Type} item was successfully updated." if @lfi.update_attributes params[:lost_and_found_item]
    respond_with @lfi
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
