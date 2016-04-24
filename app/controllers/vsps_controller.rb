# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  party      :boolean
#  notes      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VspsController < ApplicationController
  load_and_authorize_resource

  before_action :find_vsps, only: [:index]

  respond_to :html

  def create
    flash[:notice] = 'VSP created successfully!' if @vsp.save
    respond_with @vsp, location: vsps_path
  end

  def update
    flash[:notice] = 'VSP updated successfully!' if @vsp.update_attributes vsp_params
    respond_with @vsp, location: vsps_path
  end

  protected

  def find_vsps
    @people  = Vsp.people
    @parties = Vsp.parties
  end

  def vsp_params
    params.require(:vsp).permit :name, :notes, :party
  end
end
