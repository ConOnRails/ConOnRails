# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SectionsController < ApplicationController

  load_and_authorize_resource

  respond_to :html

  def create
    flash[:notice] = 'Section was created successfully.' if @section.save
    respond_with @section
  end

  def update
    flash[:notice] = 'Section was updated successfully.' if @section.update_attributes section_params
    respond_with @section, location: edit_section_path(@section)
  end

  protected

  def section_params
    params.require(:section).permit :name, { section_roles_attributes: [:id, :role_id, :section_id, :read, :secure, :write, :_destroy] }
  end
end
