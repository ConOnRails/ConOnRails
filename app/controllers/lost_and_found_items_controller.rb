class LostAndFoundItemsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  before_filter :build_categories_from_params, only: [:index]
  before_filter :find_lfi, only: [:show, :edit, :update]

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

  def index
    return jump if lfi_search_params[:id].present?
    search_type = lfi_search_params[:search_type] || 'any'

    @title = "Lost and Found Entries"

    @lfis = limit_by_convention LostAndFoundItem.inventory(lfi_search_params[:inventory], lfi_search_params[:exclude_inventoried]).page(lfi_search_params[:page]).
        where { |l| l.description.send(('like_'+search_type).to_sym, wrap_keywords_for_like) unless lfi_search_params[:keywords].blank? }.
        where { |l| l.category >> @categories unless @categories.blank? }.references(:tags)
    @lfis = lfi_search_params[:show_returned_only] ? @lfis.returned : @lfis.not_returned
    @back_params = lfi_search_params
  end

  def new
    @lfi                  = LostAndFoundItem.new
    @lfi.reported_missing = lfi_params[:reported_missing]
    @lfi.found            = lfi_params[:found]

    @title = "New #{@lfi.reported_missing ? 'Missing' : 'Found'} Item"
  end

  def create
    @lfi          = LostAndFoundItem.new lfi_params
    @lfi.user     = current_user
    @lfi.rolename = current_role_name

    flash[:notice] = "#{@lfi.Type} item was successfully created." if @lfi.save
    respond_with @lfi
  end

  def edit
    @lfi.found = true if params[:found] == 'true'
    @lfi.returned = true if params[:returned] =='true'
    @lfi.inventoried = true if params[:inventoried] == 'true'

    @title = "Edit #{@lfi.Type} Item"
  end

  def update
    @lfi.user     = current_user
    @lfi.rolename = current_role_name

    flash[:notice] = "#{@lfi.Type} item was successfully updated." if @lfi.update_attributes lfi_params
    respond_with @lfi, location: lost_and_found_item_path(@lfi, inventory: lfi_params[:inventory])
  end

  protected
  def jump
    @lfi = LostAndFoundItem.find_by_id(params[:id])
    return redirect_to lost_and_found_item_path(@lfi, inventory: params[:inventory] || false) if @lfi.present?
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

  def find_lfi
    @lfi = @lost_and_found_item
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

  def lfi_search_params
    params.permit LostAndFoundItem.valid_categories.keys + [:id, :inventory, :keywords, :search_type, :reported_found, :inventoried, :exclude_inventoried, :returned, :reported_missing, :found, :page, :show_returned_only]
  end
  alias :lost_and_found_item_params :lfi_search_params


  def lfi_params
      params.require(:lost_and_found_item).permit :reported_missing, :category, :convention, :description, :where_last_seen,
                                                  :owner_name, :owner_contact, :where_found, :details, :found, :returned,
                                                  :who_claimed, :inventoried, :search_type
  end
end
