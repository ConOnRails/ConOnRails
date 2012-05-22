class RadioGroupsController < ApplicationController
  before_filter :can_admin_radios?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_assign_radios?, only: [:index, :show]

  # GET /radio_groups
  # GET /radio_groups.json
  def index( del_or_edit = "edit")
    @radio_groups = RadioGroup.all
    @del_or_edit  = del_or_edit
    respond_to do |format|
      format.html { render "index"} # index.html.erb
      format.json { render json: @radio_groups }
    end
  end

  def delindex
    index( "delete" )
  end

  # GET /radio_groups/1
  # GET /radio_groups/1.json
  def show
    @radio_group = RadioGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @radio_group }
    end
  end

  # GET /radio_groups/new
  # GET /radio_groups/new.json
  def new
    @radio_group = RadioGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @radio_group }
    end
  end

  # GET /radio_groups/1/edit
  def edit
    @radio_group = RadioGroup.find(params[:id])
  end

  # POST /radio_groups
  # POST /radio_groups.json
  def create
    @radio_group = RadioGroup.new(params[:radio_group])

    respond_to do |format|
      if @radio_group.save
        format.html { redirect_to @radio_group, notice: 'Radio group was successfully created.' }
        format.json { render json: @radio_group, status: :created, location: @radio_group }
      else
        format.html { render action: "new" }
        format.json { render json: @radio_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radio_groups/1
  # PUT /radio_groups/1.json
  def update
    @radio_group = RadioGroup.find(params[:id])

    respond_to do |format|
      if @radio_group.update_attributes(params[:radio_group])
        format.html { redirect_to @radio_group, notice: 'Radio group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @radio_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radio_groups/1
  # DELETE /radio_groups/1.json
  def destroy
    @radio_group = RadioGroup.find(params[:id])
    @radio_group.destroy

    respond_to do |format|
      format.html { redirect_to radio_groups_url }
      format.json { head :ok }
    end
  end
end
