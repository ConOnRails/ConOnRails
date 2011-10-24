class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @title = "Event Log"
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def active
    @title = "Active Events"
    @events = Event.find_all_by_is_active(true)
    
    respond_to do |format|
      format.html { render "index"}
      format.json { render json: @events}
    end
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

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
    @time  = Time.now

    respond_to do |format|
      format.html
      format.json { render json: @event }
    end
    
  end
  
  def create
    @event = Event.new(params[:event])
    @event.entries.build({ description: @event.firstdescription, user: current_user, event: @event })

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

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @user  = User.find(session[:user_id])
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

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
