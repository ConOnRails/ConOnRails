class EventsController < ApplicationController
  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]

  protected

  def user_can_see_hidden
    return current_user == nil ? false : current_user.read_hidden_entries?
  end

  public

  def build_new_entry(event)
    entry       = event.entries.build
    entry.event = event
    entry.user  = current_user
    return entry
  end

  def build_entry_from_params(event, params)
    entry       = event.entries.build(params)
    entry.event = event
    entry.user  = current_user
  end

  def filter_hidden_if_needed
    @events = nil
    if user_can_see_hidden
      @events = Event.order("updated_at desc")
    else
      @events = Event.order("updated_at desc").find_all_by_hidden(false)
    end
  end

  def subwombat
    events = nil
    if session[:actives]
      events = Event.order("updated_at desc").find_all_by_hidden_and_is_active( false, true )
    else
      events = filter_hidden_if_needed
    end
    render partial: 'event', content_type: 'text/html', collection: events, locals: { form: false, actives: session[:actives] }
  end

  # GET /events
  # GET /events.json
  def index
    @title   = "Event Log"
    @events  = filter_hidden_if_needed
    @actives = false
    session[:actives] = nil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def active
    @title   = "Active Events"
    @events  = Event.order("updated_at desc").find_all_by_hidden_and_is_active(false, true)
    session[:actives] = true
    @actives = true

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @entry = build_new_entry @event

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  # There is POST /events. We actually create the new event here and then redirect to create the first entry
  def new
    @event = Event.new
    @entry = build_new_entry @event
    if params[:emergency] == '1'
      @event.emergency = true
    end

    respond_to do |format|
      format.html
      format.json { render json: @event }
    end

  end

  def create
    @event = Event.new(params[:event])
    build_entry_from_params(@event, params[:entry])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
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
    build_entry_from_params(@event, params[:entry]) if params[:entry][:description] != ''

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        # It is more or less impossible to supply invalid parameters to events. Here's why:
        # events themselves have almost no validation to them. There are no illegal states and the
        # defaults are all reasonable.
        # entries cannot actually be updated right now -- events can be updated by adding
        # entries, and we only do that if a description is provided, and then we make sure the user and event
        # fields are set up correctly, so validation is guaranteed to pass.
        # IFF entries become editable, then there will need to be some tweaking there.
        #format.html { render action: "edit" }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
