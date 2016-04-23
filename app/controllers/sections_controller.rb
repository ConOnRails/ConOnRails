class SectionsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def create
    flash[:notice] = 'Section was created' if @section.save
    respond_with @section
  end

  def update
    flash[:notice] = 'Section was updated' if @section.update_attributes section_params
    respond_with @section
  end

  def destroy
    @section.delete
    respond_with @section, location: :sections
  end

  protected

  def section_params
    params.require(:section).permit(:name)
  end
end
