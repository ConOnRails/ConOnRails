# == Schema Information
#
# Table name: radio_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  color      :string(255)
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RadioGroupsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  # GET /radio_groups
  # GET /radio_groups.json
  def index(del_or_edit = "edit")
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

  def radio_group_params
    params.require(:radio_group).permit :name, :color, :notes
  end
end
