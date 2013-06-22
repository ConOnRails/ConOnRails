class EventsController < ApplicationController

  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]

  respond_to :html, :json
  respond_to :js, only: [:index, :sticky, :secure, :review]

  public

  # GET /events
  # GET /events.json
  def index
    @events = Event.for_index.
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events
  end

  def sticky
    @events = Event.for_sticky.
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def secure
    (redirect_to(root_url) and return) unless current_user.can_read_secure?
    @events = Event.for_secure.
        order { |e| e.updated_at.desc }.page(params[:page])
    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def search_entries
    @q = params[:q] # We'll use this to re-fill the search blank
    @events = Event.search(@q, current_user, params[:show_closed])
    respond_with @events
  end

  def review
    @events = Event.for_review(params[:filters], current_user).
        order { |e| e.updated_at.asc }.page(params[:page])
    respond_with @events
  end


  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @entry = build_new_entry @event

    respond_with @event
  end

  # GET /events/new
  # GET /events/new.json
  # There is POST /events. We actually create the new event here and then redirect to create the first entry
  def new
    @event = Event.new
    @event.emergency = true if params[:emergency] == '1'
    @entry = build_new_entry @event

    respond_with @event
  end

  def create
    @event = Event.new(params[:event])
    build_entry_from_params(@event, params[:entry])
    build_flag_history_from_params(@event, params[:event])

    flash[:notice] = 'Event was successfully created.' if @event.save

    respond_with @event
  end

  def create_emergency
  end

# GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

# PUT /events/1
# PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    build_entry_from_params(@event, params[:entry]) if params[:entry] and params[:entry][:description] != ''
    build_flag_history_from_params @event, params[:event] if params[:event] and @event.flags_differ? params[:event]

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
    entry          = event.entries.build
    entry.event    = event
    entry.user     = current_user
    entry.rolename = current_role
    return entry
  end

  def build_entry_from_params(event, params)
    entry          = event.entries.build(params)
    entry.event    = event
    entry.user     = current_user
    entry.rolename = current_role
  end

  def build_flag_history_from_params(event, params)
    hist          = event.event_flag_histories.build(params)
    hist.event    = event
    hist.user     = current_user
    hist.rolename = current_role
  end
end
