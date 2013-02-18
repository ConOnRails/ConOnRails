class EventsController < ApplicationController
  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]
  before_filter :get_filtered_events, only: [:index, :review]
#  respond_to :html, :json

  public

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

  # GET /events
  # GET /events.json
  def index
    @events = @events.page(params[:page])
    #@events = Event.build_filter(current_user, params).order(:updated_at).reverse_order.page(params[:page])
  end

  def review
    @events = Event.build_filter(current_user, params).order(:updated_at).page(params[:page])
  end

  def sticky
    zog = {}
    zog[:filters] ||= {}
    zog[:filters][:sticky] = "true"
    @events = Event.build_filter(current_user, zog).order(:updated_at).page(params[:page])
    render action: :review, params: zog
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
    build_flag_history_from_params(@event, params[:event])

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
    build_entry_from_params(@event, params[:entry]) if params[:entry] and params[:entry][:description] != ''
    build_flag_history_from_params @event, params[:event] if params[:event] and @event.flags_differ? params[:event]

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

  protected

  def get_filtered_events
    @events = Event
    @events = @events.where { |e| e.hidden == false } if does_not_want_hidden or cannot_see_hidden
    @events = @events.where { |e| e.secure == false } if does_not_want_secure or cannot_see_secure
  end

  def does_not_want_hidden
    return true unless params[:filters].present? && params[:filters][:hidden].present? && params[:filters][:hidden] == true
    false
  end

  def does_not_want_secure
    return true unless params[:filters].present? && params[:filters][:secure].present? && params[:filters][:secure] == true
    false
  end

  def cannot_see_hidden
    return true unless current_user.can_read_hidden?
    false
  end

  def cannot_see_secure
    return true unless current_user.can_read_secure?
    false
  end

end
