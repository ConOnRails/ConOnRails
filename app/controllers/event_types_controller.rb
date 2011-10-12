class EventTypesController < ApplicationController
  # GET /event_types
  # GET /event_types.json
  def index
    @event_types = EventType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_types }
    end
  end

  # GET /event_types/1
  # GET /event_types/1.json
  def show
    @event_type = EventType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/new
  # GET /event_types/new.json
  def new
    @event_type = EventType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/1/edit
  def edit
    @event_type = EventType.find(params[:id])
  end

  # POST /event_types
  # POST /event_types.json
  def create
    @event_type = EventType.new(params[:event_type])

    respond_to do |format|
      if @event_type.save
        format.html { redirect_to @event_type, notice: 'Event type was successfully created.' }
        format.json { render json: @event_type, status: :created, location: @event_type }
      else
        format.html { render action: "new" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_types/1
  # PUT /event_types/1.json
  def update
    @event_type = EventType.find(params[:id])

    respond_to do |format|
      if @event_type.update_attributes(params[:event_type])
        format.html { redirect_to @event_type, notice: 'Event type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1
  # DELETE /event_types/1.json
  def destroy
    @event_type = EventType.find(params[:id])
    @event_type.destroy

    respond_to do |format|
      format.html { redirect_to event_types_url }
      format.json { head :ok }
    end
  end
end
