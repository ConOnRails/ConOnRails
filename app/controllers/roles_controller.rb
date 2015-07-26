class RolesController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new role_params
    flash[:notice] = 'Role was successfully created.' if @role.save
    respond_with @role
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    flash[:notice] = 'Role was successfully updated.' if @role.update_attributes role_params
    respond_with @role
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_with @role, location: roles_path
  end

  protected

  def role_params
    params.require(:role).permit :name, :write_entries, :add_lost_and_found, :admin_duty_board, :admin_radios, :admin_schedule,
                                 :admin_users, :assign_duty_board_slots, :assign_radios, :assign_shifts, :modify_lost_and_found,
                                 :read_hidden_entries, :make_hidden_entries, :read_audits, :rw_secure
  end
end
