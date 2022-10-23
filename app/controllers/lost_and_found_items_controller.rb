# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class LostAndFoundItemsController < ApplicationController
  respond_to :html, :json

  before_action :categories, only: [:index]
  before_action :find_lfi, only: %i[show edit update]

  def index # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    return jump if lfi_search_params[:id].present?

    search_type = lfi_search_params[:search_type] || 'any'

    @title = 'Lost and Found Entries'

    @lfis = limit_by_convention policy_scope(LostAndFoundItem)
            .inventory(lfi_search_params[:inventory],
                       lfi_search_params[:exclude_inventoried])
            .page(lfi_search_params[:page]),
                                table: 'lost_and_found_items'
    if lfi_search_params[:keywords].present?
      @lfis = @lfis.where("(#{build_like('description', search_type)}) OR
                           (#{build_like('details', search_type)})")
    end
    @lfis = @lfis.where(category: @categories).references(:tags) if @categories.present?
    @lfis = lfi_search_params[:show_returned_only] ? @lfis.returned : @lfis.not_returned
    authorize @lfis
    @back_params = lfi_search_params
  end

  def show; end

  def new
    @lfi = LostAndFoundItem.new
    authorize @lfi

    @lfi.reported_missing = lfi_params[:reported_missing]
    @lfi.found            = lfi_params[:found]

    @title = "New #{@lfi.reported_missing ? 'Missing' : 'Found'} Item"
  end

  def edit
    @lfi.found = true if params[:found] == 'true'
    @lfi.returned = true if params[:returned] == 'true'
    @lfi.inventoried = true if params[:inventoried] == 'true'

    @title = "Edit #{@lfi.type_name} Item"
  end

  def create
    @lfi = LostAndFoundItem.new lfi_params
    authorize @lfi

    @lfi.user     = current_user
    @lfi.rolename = current_role_name

    if @lfi.save
      flash.now[:notice] =
        "TAG WITH #{@lfi.id} - #{@lfi.type_name} item was successfully created."
    end
    respond_with @lfi
  end

  def update
    @lfi.user     = current_user
    @lfi.rolename = current_role_name

    if @lfi.update lfi_params
      flash.now[:notice] =
        "#{@lfi.type_name} item was successfully updated."
    end
    respond_with @lfi, location: lost_and_found_item_path(@lfi, inventory: lfi_params[:inventory])
  end

  def searchform
    authorize :lost_and_found_item, :index?
  end

  def export
    respond_with do |f|
      @lfis = policy_scope(LostAndFoundItem).inventoried.order(:id)
      authorize @lfis, :index?
      f.csv do
        send_data LostAndFoundItem.to_csv(@lfis), filename: 'lost-and-found-inventory.csv',
                                                  type: 'text/csv'
      end
    end
  end

  protected

  def jump
    @lfi = policy_scope(LostAndFoundItem).find_by(id: params[:id])
    authorize @lfi
    if @lfi.present?
      return redirect_to lost_and_found_item_path(@lfi,
                                                  inventory: params[:inventory] || false)
    end

    render 'invalid'
  end

  def build_like(which, search_type)
    wrap_keywords_for_like.collect do |k|
      "#{which} ILIKE #{k}"
    end.join(search_type == 'all' ? ' AND ' : ' OR ')
  end

  def wrap_keywords_for_like
    params[:keywords].split.collect { |s| ActiveRecord::Base.connection.quote "%#{s}%" }
  end

  private

  def categories
    @categories ||= fix_old_categories(
      LostAndFoundItem.categories.collect do |k, v|
        next unless params.key? k.to_s

        v
      end.compact
    ).flatten
  end

  def find_lfi
    @lfi = LostAndFoundItem.find params[:id]
    authorize @lfi
  end

  def fix_old_categories(cats)
    @map ||= {
      'Badges' => %w[Badge Badges],
      'Bags' => %w[Bag Bags],
      'Bottles' => %w[Bottle Bottles],
      'Money/Cards/ID' => ['Money', 'Money/Cards/ID'],
      'Phones' => %w[Phone Phones],
      'Weapons/Props' => ['Weapon', 'Weapons/Props']
    }

    cats.collect { |c| @map[c] || c }
  end

  def lfi_search_params
    params.permit LostAndFoundItem.categories
                                  .keys + %i[id inventory keywords search_type
                                             reported_found inventoried exclude_inventoried returned
                                             reported_missing found page show_returned_only]
  end

  def lfi_params
    params.require(:lost_and_found_item)
          .permit :reported_missing, :category, :description, :where_last_seen,
                  :owner_name, :owner_contact, :where_found, :details, :found, :returned,
                  :who_claimed, :inventoried, :search_type
  end
end
# rubocop:enable Metrics/ClassLength
