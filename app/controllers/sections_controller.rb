class SectionsController < ApplicationController
  load_and_authorize_resource

  before_action :get_users, only: :edit

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
    params.require(:section).permit(:name, user_ids: [])
  end

  def get_users
    @users = User.where.not(id: @section.users)
  end
end
