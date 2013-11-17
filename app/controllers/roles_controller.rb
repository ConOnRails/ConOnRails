class RolesController < ApplicationController
  before_filter :redirect_if_cannot_admin

  respond_to :html, :json

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @role = Role.find(params[:id])
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
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
    @role = Role.find(params[:id])
    flash[:notice] = 'Role was successfully updated.' if @role.update_attributes role_params
    respond_with @role
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    respond_with @role, location: roles_path
  end

  protected

  def redirect_if_cannot_admin
    unless current_user and current_user.can_admin_users?
      redirect_to public_url
    end
  end

  def role_params
    params.require(:role).permit :name, :write_entries, :add_lost_and_found, :admin_duty_board, :admin_radios, :admin_schedule,
                                 :admin_users, :assign_duty_board_slots, :assign_radios, :assign_shifts, :modify_lost_and_found,
                                 :read_hidden_entries, :make_hidden_entries, :read_audits, :rw_secure
  end
end
