class SectionsController < ApplicationController

  load_and_authorize_resource

  respond_to :html

  def create
    flash[:notice] = 'Section was created successfully.' if @section.save
    respond_with @section
  end

  def update
    flash[:notice] = 'Section was updated successfully.' if do_update
    respond_with @section
  end

  protected

  def do_update
    Section.transaction do
      unless params['section']['section_role'].blank?
        # Remove everything that's not set
        role_ids = Role.all.pluck(:id)
        roles_mentioned = params['section']['section_role'].keys
        remove_these_ids = role_ids.reject { |r| roles_mentioned.include? r }
        remove_these = @section.section_roles.where(role_id: remove_these_ids)
        @section.section_roles.delete remove_these

        # Add what is set
        params['section']['section_role'].each do |k, v|
          v.each do |p, pv|
            if pv == '1'
              @section.section_roles.build role_id: k, permission: p
            end
          end
        end
      end

      #normal param updates
      @section.update_attributes section_params
    end
  end

  def section_params
    params.require(:section).permit :name, :section_role
  end
end
