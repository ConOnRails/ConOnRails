class RadiosController < ApplicationController
  before_filter :can_admin_radios?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_assign_radios?, only: [:index, :show ]

  # GET /radios
  # GET /radios.json
  def index
    @radios = Radio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radios }
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
