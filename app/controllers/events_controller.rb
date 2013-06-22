class EventsController < ApplicationController

  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]

  #  respond_to :html, :json

  public

  # GET /events
  # GET /events.json
  def index
    @events = Event.for_index.
        page(params[:page]).order { |e| e.updated_at.desc }
  end

  def sticky
    @events = Event.for_sticky.
        page(params[:page]).order { |e| e.updated_at.desc }
    render :index
  end

  def secure
    if current_user.can_read_secure?
      @events = Event.for_secure.
          page(params[:page]).order { |e| e.updated_at.desc }
      render :index
    else
      redirect_to root_url
    end
  end

  def search_entries
    @q = params[:q] # We'll use this to re-fill the search blank

    @events = Event
    @events = @events.where { |e| (e.secure == false) & (e.hidden == false) } unless current_user.can_read_secure?
    @events = @events.where { |e| (e.is_active == true) | (e.sticky == true) } unless params[:show_closed]
    @events = @events.search_entries params[:q]
    render :search_results
  end

  def review
    query = params[:filters].reduce(Squeel::Nodes::Stub.new(:created_at).not_eq(nil)) do |query, key|
      query = query.& Squeel::Nodes::KeyPath.new(key.first.to_sym).eq(fix_bool key.second) unless key.second == 'all'
      query
    end if params[:filters].present?

    @events = Event.where { query }
    @events = @events.where { |e| e.hidden == false } if cannot_see_hidden
    @events = @events.where { |e| e.secure == false } if cannot_see_secure
    @events = @events.order { |e| e.updated_at.asc }.page(params[:page])
  end

  def fix_bool val
    if val.is_a? String
      return true if val == 'true'
      return false if val == 'false'
    end
    val
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

  def merge_events
    @event = Event.merge_events(params[:merge_ids], current_user, current_role)
    if @event.present?
      respond_to do |format|
        format.html { redirect_to edit_event_path(@event), notice: 'Event was merged. Check and save.' }
        format.json { render json: @event, status: :merged, location: @event }
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: 'No IDs selected for merge. Nothing done.' }
        format.json { render json: { message: 'No IDs selected for merge', status: :unprocessable_entity } }
      end
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


  # A README about filtering
  #
  # There are a lot of ways I could implement this. At one point, it was all on the model, but badly. I thought about
  # using scopes or class-methods for the various pieces. I may yet factor things out that way, but for now, this is
  # the best approach I can think of that cleanly represents the ruleset we want to follow for any given combination.
  #
  # Should anyone read this code, critiques and suggestions are gratefully accepted.

  def filter(term)
    if params[:filters].present?
      if params[:filters][term].present?
        if term == :hidden && params[:filters][term].presence == true
        end

      end
    end

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
