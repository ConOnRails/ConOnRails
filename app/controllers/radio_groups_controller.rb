class RadioGroupsController < ApplicationController
  respond_to :html, :json

  before_filter :can_admin_radios?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_assign_radios?, only: [:index, :show]
  before_filter :find_radio_group, only: [:show, :edit, :update, :destroy]


  # GET /radio_groups
  # GET /radio_groups.json
  def index(del_or_edit = "edit")
    @radio_groups = RadioGroup.all
    @del_or_edit  = del_or_edit
  end

  def delindex
    index("delete")
  end

  # GET /radio_groups/new
  # GET /radio_groups/new.json
  def new
    @radio_group = RadioGroup.new
  end

  # POST /radio_groups
  # POST /radio_groups.json
  def create
    @radio_group = RadioGroup.new radio_group_params
    flash[:notice] = 'Radio group was successfully created.' if @radio_group.save
    respond_with @radio_group
  end

  # PUT /radio_groups/1
  # PUT /radio_groups/1.json
  def update
    flash[:notice] = 'Radio group was successfully updated.' if @radio_group.update_attributes radio_group_params
    respond_with @radio_group
  end

  # DELETE /radio_groups/1
  # DELETE /radio_groups/1.json
  def destroy
    @radio_group.destroy
    respond_with @radio_group, location: radio_groups_path
  end

  protected

  def find_radio_group
    @radio_group = RadioGroup.find(params[:id])
  end

  def radio_group_params
    params.require(:radio_group).permit :name, :color, :notes
  end
end
