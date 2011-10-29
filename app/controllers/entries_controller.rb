class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
    @event = Event.find(params[:event_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @event = Event.find(params[:event_id])
    @entry = Entry.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])
    @entry.event = Event.find(params[:event_id])
    @entry.user  = User.find(session[:user_id])

    respond_to do |format|
      if @entry.description == "" or @entry.save
        # We also need to update event attributes
        @entry.event.update_attributes(params[:event])
        
        format.html { redirect_to @entry.event, notice: 'Entry was successfully created.' }
        format.json { render json: @entry.event, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end
end
