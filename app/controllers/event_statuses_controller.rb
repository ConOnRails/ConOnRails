class EventStatusesController < ApplicationController
  # GET /event_statuses
  # GET /event_statuses.json
  def index
    @event_statuses = EventStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_statuses }
    end
  end

  # GET /event_statuses/1
  # GET /event_statuses/1.json
  def show
    @event_status = EventStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_status }
    end
  end

  # GET /event_statuses/new
  # GET /event_statuses/new.json
  def new
    @event_status = EventStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_status }
    end
  end

  # GET /event_statuses/1/edit
  def edit
    @event_status = EventStatus.find(params[:id])
  end

  # POST /event_statuses
  # POST /event_statuses.json
  def create
    @event_status = EventStatus.new(params[:event_status])

    respond_to do |format|
      if @event_status.save
        format.html { redirect_to @event_status, notice: 'Event status was successfully created.' }
        format.json { render json: @event_status, status: :created, location: @event_status }
      else
        format.html { render action: "new" }
        format.json { render json: @event_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_statuses/1
  # PUT /event_statuses/1.json
  def update
    @event_status = EventStatus.find(params[:id])

    respond_to do |format|
      if @event_status.update_attributes(params[:event_status])
        format.html { redirect_to @event_status, notice: 'Event status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_statuses/1
  # DELETE /event_statuses/1.json
  def destroy
    @event_status = EventStatus.find(params[:id])
    @event_status.destroy

    respond_to do |format|
      format.html { redirect_to event_statuses_url }
      format.json { head :ok }
    end
  end
end
