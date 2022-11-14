# frozen_string_literal: true

class RadioGroupsController < ApplicationController
  respond_to :html, :json

  before_action :find_radio_group, only: %i[show edit update destroy]

  def index(del_or_edit = 'edit')
    @radio_groups = policy_scope(RadioGroup).all
    authorize @radio_groups
    @del_or_edit = del_or_edit
  end

  def show; end

  # GET /radio_groups
  # GET /radio_groups.json
  def new
    @radio_group = RadioGroup.new
    authorize @radio_group
  end

  def delindex
    index('delete')
  end

  # GET /radio_groups/new
  # GET /radio_groups/new.json
  def edit; end

  # POST /radio_groups
  # POST /radio_groups.json
  def create
    @radio_group = RadioGroup.new radio_group_params
    authorize @radio_group
    flash.now[:notice] = 'Radio group was successfully created.' if @radio_group.save
    respond_with @radio_group
  end

  # PUT /radio_groups/1
  # PUT /radio_groups/1.json
  def update
    if @radio_group.update radio_group_params
      flash.now[:notice] =
        'Radio group was successfully updated.'
    end
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
    authorize @radio_group
  end

  def radio_group_params
    params.require(:radio_group).permit :name, :color, :notes
  end
end
