class LostAndFoundItemsController < ApplicationController
  respond_to :html, :json

  before_filter :user_can_add_lost_and_found, only: [:new, :create]
  before_filter :user_can_modify_lost_and_found, only: [:edit, :update]
  before_filter :build_categories_from_params, only: [:index]

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
    search_type = params[:search_type] || 'any'

    @lfis = limit_by_convention LostAndFoundItem.inventory(params[:inventory]).page(params[:page]).
        where { |l| l.returned == false unless params[:show_returned] }.
        where { |l| l.description.send(('like_'+search_type).to_sym, wrap_keywords_for_like) unless params[:keywords].blank? }.
        where { |l| l.category >> @categories unless @categories.blank? }
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
    @categories ||= fix_old_categories((LostAndFoundItem.categories.collect do |k, v|
      next unless params.has_key? k.to_s
      v
    end).compact).flatten
  end

  def fix_old_categories(cats)
    @map ||= {
        'Badges'         => ['Badge', 'Badges'],
        'Bags'           => ['Bag', 'Bags'],
        'Bottles'        => ['Bottle', 'Bottles'],
        'Money/Cards/ID' => ['Money', 'Money/Cards/ID'],
        'Phones'         => ['Phone', 'Phones'],
        'Weapons/Props'  => ['Weapon', 'Weapons/Props']
    }

    cats.collect do |c|
      @map[c] || c
    end
  end
end
