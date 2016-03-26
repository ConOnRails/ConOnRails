# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_active       :boolean          default(TRUE)
#  post_con        :boolean          default(FALSE)
#  sticky          :boolean          default(FALSE)
#  emergency       :boolean          default(FALSE)
#  medical         :boolean          default(FALSE)
#  hidden          :boolean          default(FALSE)
#  secure          :boolean          default(FALSE)
#  consuite        :boolean
#  hotel           :boolean
#  parties         :boolean
#  volunteers      :boolean
#  dealers         :boolean
#  dock            :boolean
#  merchandise     :boolean
#  merged_from_ids :string(255)
#  merged          :boolean
#  nerf_herders    :boolean
#  section_id      :integer
#

require Rails.root + 'app/queries/event_queries'

class EventsController < ApplicationController
  include Queries::EventQueries

  #before_filter :can_read_secure?, only: [:secure]
  #before_filter :can_write_entries?, only: [:new, :create, :edit, :update]
  #before_filter :set_event, only: [:show, :edit, :update]
  before_filter :get_tagged_events, only: [:tag]
  before_filter :process_filters, only: [:review, :export]

  before_filter :get_sticky_events, only: [:sticky]
  before_filter :get_secure_events, only: [:secure]
  load_and_authorize_resource except: [:merge_events]
  load_and_authorize_resource :entry, through: :event

  respond_to :html, :json, except: [:export]
  respond_to :js, only: [:index, :sticky, :secure, :review]
  respond_to :csv, only: [:export]

  public

  # GET /events
  # GET /events.json
  def index
    @title = 'Active Events'
    return jump if params[:id].present?
    @available_sections = Section.sections_for_roles current_user.roles, 'read'
    @events = IndexQuery.new(Event).query(session[:index_filter]).
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events
  end

  def sticky
    @title = 'Sticky Events'

    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def secure
    @title = 'Secure Events'

    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def tag
    respond_with do |format|
      format.json { render :index }
    end
  end

  def search_entries
    @q = params[:q] # We'll use this to re-fill the search blank
    @events = limit_by_convention Event.search(@q, current_user, params[:show_closed], session[:index_filter])
    respond_with @events
  end

  def review
    @title = 'Event Review'
    respond_with @events
  end


  # GET /events/1
  # GET /events/1.json
  def show
    @title = 'Event'
    @entry = build_new_entry @event
  end

  # GET /events/new
  # GET /events/new.json
  # There is POST /events. We actually create the new event here and then redirect to create the first entry
  def new
    @title = 'New Event'
    @event = Event.new
    @event.flags = session[:index_filter] if session[:index_filter]
    @event.emergency = true if params[:emergency] == '1'
    @entry = build_new_entry @event
  end

  def create
    @event = Event.create event_params
    build_entry_from_params @event, entry_params
    build_flag_history_from_params @event, event_params, true
    flash[:notice] = 'Event was successfully created.' if @event.save

    respond_with @event
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    # strong_parameters balks a bit at the permissiveness of this. Might want to consider restructuring a bit

    build_entry_from_params @event, entry_params if params.has_key? :entry #this can be blank!
    build_flag_history_from_params @event, event_params if params.has_key? :event # this can also be blank if nothing changed!

    if params.has_key? :event
      flash[:notice] = 'Event was successfully updated.' if @event.update_attributes event_params
    else
      flash[:notice] = 'Event was successfully updated.' if @event.save
    end

    respond_with @event
  end

  def merge_events
    @event = Event.merge_events merge_id_params, current_user, current_role_name
    authorize! :update, @event

    if @event.present?
      flash[:notice] = 'Event was merged. Check and save.'
      respond_with @event, location: edit_event_path(@event)
    else
      redirect_to request.referrer, notice: 'No IDs selected for merge. Nothing done.'
    end
  end

  def export
    respond_with do |f|
      f.csv { send_data Event.to_csv(@events), type: 'text/csv' }
    end
  end

  protected

  def build_new_entry(event)
    event.entries.build event: event, user: current_user, rolename: current_role_name
  end

  def build_entry_from_params(event, params)
    return unless params and params[:description] != ''
    event.entries.build(params.merge({ event: event, user: current_user, rolename: current_role_name }))
  end

  def build_flag_history_from_params(event, params, always=false)
    return unless always or (params and @event.flags_differ? params)
    event.event_flag_histories.build(params.merge({ event: event, user: current_user, rolename: current_role_name }))
  end

  def filter_order
    return 'asc' unless params.has_key?(:filters) && params[:filters].has_key?(:order)
    params[:filters][:order]
  end

  def get_sticky_events
    @events = (limit_by_convention StickyQuery.new(Event).query.
                                       order { |e| e.updated_at.desc }).page(params[:page])
  end

  def get_secure_events
    @events = SecureQuery.new(Event).query.
        order { |e| e.updated_at.desc }.page(params[:page])
  end

  def get_tagged_events
    @events = IndexQuery.new(Event).query.tagged_with(params[:tag]).
        order { |e| e.updated_at.desc }
  end

  def jump
    event = Event.find_by_id(params[:id])
    return redirect_to event_path(params[:id]) if event
    render 'lost_and_found_items/invalid'
  end

  def process_filters
    @q = params[:q]

    @events = limit_by_convention FiltersQuery.new(Event.where {}, params[:filters]).query.protect_sensitive_events(current_user)
    @events = limit_by_date_range @events
    @events = @events.order(updated_at: filter_order)
    @events = @events.search_entries(@q) if @q.present?
    @events = @events.page(params[:page])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit :is_active, :comment, :flagged, :post_con, :quote, :sticky, :emergency,
                                  :medical, :hidden, :secure, :consuite, :hotel, :parties, :volunteers,
                                  :dealers, :dock, :merchandise, :nerf_herders, :status, :alert_dispatcher, :tag
  end

  def entry_params
    params.require(:entry).permit :description, :event, :user, :rolename
  end

  def merge_id_params
    params.require(:merge_ids)
  end

end
