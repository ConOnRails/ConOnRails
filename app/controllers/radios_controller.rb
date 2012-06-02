class RadiosController < ApplicationController
  before_filter :can_admin_radios?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_assign_radios?, only: [:index, :show, :search_volunteers]
  respond_to :html

  # POST /radios/search_volunteers
  def search_volunteers
    @volunteers = Volunteer.radio_volunteer(params[:first_name],
                                            params[:last_name])
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'volunteers', locals: { radio: params[:radio] }
        else
          redirect_to public_url
        end
      end
    end
  end

  # GET /radios/1/select_department?volunteer=1
  def select_department
    radio = Radio.find params[:id]
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'select_department', locals: { radio: params[:id],
                                                         radio_group: radio.radio_group.id,
                                                         volunteer: params[:volunteer] }
        else
          redirect_to public_url
        end
      end
    end
  end

  # GET /radios
  # GET /radios.json
  def index
    @radios = Radio.order(:radio_group_id, :state)

    p @radios

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Radio.all }
    end
  end

  # GET /radios/1
  # GET /radios/1.json
  def show
    @radio = Radio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @radio }
    end
  end

  # GET /radios/new
  # GET /radios/new.json
  def new
    @radio = Radio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @radio }
    end
  end

  # GET /radios/1/assign
  def checkout
    @radio            = Radio.find params[:id]
    @radio_assignment = RadioAssignment.new
  end

  def checkin
    @radio = Radio.find params[:id]
  end

  # GET /radios/1/edit
  def edit
    @radio = Radio.find(params[:id])
  end

  # POST /radios
  # POST /radios.json
  def create
    @radio = Radio.new(params[:radio])

    respond_to do |format|
      if @radio.save
        format.html { redirect_to @radio, notice: 'Radio was successfully created.' }
        format.json { render json: @radio, status: :created, location: @radio }
      else
        format.html { render action: "new" }
        format.json { render json: @radio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radios/1
  # PUT /radios/1.json
  def update
    @radio = Radio.find(params[:id])
    if params[:radio_assignment]
      @radio.radio_assignment = RadioAssignment.new params[:radio_assignment]
    end

    respond_to do |format|
      if @radio.update_attributes(params[:radio])
        format.html { redirect_to @radio, notice: 'Radio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @radio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radios/1
  # DELETE /radios/1.json
  def destroy
    @radio = Radio.find(params[:id])
    @radio.destroy

    respond_to do |format|
      format.html { redirect_to radios_url }
      format.json { head :ok }
    end
  end
end
