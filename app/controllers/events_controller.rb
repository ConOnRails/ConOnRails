class EventsController < ApplicationController
  before_filter :user_can_write_entries, only: [ :new, :create, :edit, :update ]
  
  protected
  
  def user_can_write_entries
    unless current_user and current_user.write_entries?
      redirect_to root_url
    end
  end
  
  def user_can_see_hidden
    return current_user == nil ? false : current_user.read_hidden_entries?
  end
    
  public
  
  def build_new_entry( event )
    entry = event.entries.build
    entry.event = event
    entry.user  = current_user
    return entry
  end
  
  def build_entry_from_params( event, params )
    entry = event.entries.build( params )
    entry.event = event
    entry.user = current_user
  end
  
  def filter_out_hidden_if_needed
    ret = []
    if user_can_see_hidden
      ret = Event.order("updated_at desc")
    else
      ret = Event.order("updated_at desc").find_all_by_hidden(false)
    end
    
    return ret
  end

  # GET /events
  # GET /events.json
  def index
    @title = "Event Log"
    @events = filter_out_hidden_if_needed
    @actives = false
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def active
    @title = "Active Events"
    @events = Event.order("updated_at desc").find_all_by_is_active(true)
    @actives = true
    
    respond_to do |format|
      format.html { render "index"}
      format.json { render json: @events}
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
    build_entry_from_params( @event, params[:entry] )

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
    build_entry_from_params( @event, params[:entry] ) if params[:entry][:description] != ''

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
end
