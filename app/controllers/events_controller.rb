require Rails.root + 'app/queries/event_queries'

class EventsController < ApplicationController
  include Queries::EventQueries

  before_filter :can_read_secure?, only: [:secure]
  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]
  before_filter :set_event, only: [:show, :edit, :update]
  before_filter :set_convention_param, only: [:sticky]

  respond_to :html, :json
  respond_to :js, only: [:index, :sticky, :secure, :review]

  public

  # GET /events
  # GET /events.json
  def index
    @events = IndexQuery.new(Event).query.
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events
  end

  def sticky
    @events = limit_by_convention StickyQuery.new(Event).query.
                                      order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def secure
    @events = SecureQuery.new(Event).query.
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def search_entries
    @q      = params[:q] # We'll use this to re-fill the search blank
    @events = limit_by_convention Event.search(@q, current_user, params[:show_closed])
    respond_with @events
  end

  def review
    @events = limit_by_convention FiltersQuery.new(Event, params[:filters]).query.protect_sensitive_events(current_user).
                                      order { |e| e.updated_at.asc }.page(params[:page])
    respond_with @events
  end


  # GET /events/1
  # GET /events/1.json
  def show
    @entry = build_new_entry @event
  end

  # GET /events/new
  # GET /events/new.json
  # There is POST /events. We actually create the new event here and then redirect to create the first entry
  def new
    @event = Event.new
    @event.emergency = true if params[:emergency] == '1'
    @entry = build_new_entry @event
  end

  def create
    @event = Event.create(params[:event])
    build_entry_from_params(@event, params[:entry])
    build_flag_history_from_params(@event, params[:event], true)
    flash[:notice] = 'Event was successfully created.' if @event.save

    respond_with @event
  end

  def create_emergency
  end

# GET /events/1/edit
  def edit
  end

# PUT /events/1
# PUT /events/1.json
  def update
    build_entry_from_params(@event, params[:entry])
    build_flag_history_from_params @event, params[:event]

    flash[:notice] = 'Event was successfully updated.' if @event.update_attributes(params[:event])
    respond_with @event
  end

  def merge_events
    @event = Event.merge_events(params[:merge_ids], current_user, current_role)
    if @event.present?
      flash[:notice] = 'Event was merged. Check and save.'
      respond_with @event, location: edit_event_path(@event)
    else
      redirect_to request.referrer, notice: 'No IDs selected for merge. Nothing done.'
    end
  end

  protected

  def build_new_entry(event)
    event.entries.build event: event, user: current_user, rolename: current_role
  end

  def build_entry_from_params(event, params)
    return unless params and params[:description] != ''
    event.entries.build(params.merge({ event: event, user: current_user, rolename: current_role }))
  end

  def build_flag_history_from_params(event, params, always=false)
    return unless always or (params and @event.flags_differ? params)
    event.event_flag_histories.build(params.merge({ event: event, user: current_user, rolename: current_role }))
  end

  def set_convention_param
    params[:convention] = Convention.most_recent.id if (params[:convention].blank? && params[:show_older] == 'false')
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
