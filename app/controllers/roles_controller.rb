# frozen_string_literal: true

class RolesController < ApplicationController
  respond_to :html, :json

  before_action :find_role, only: %i[show edit update destroy]
  before_action :find_roles, only: [:index]

  def index; end
  def show; end
  def edit; end

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new
    authorize @role
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new role_params
    authorize @role
    flash[:notice] = 'Role was successfully created.' if @role.save
    respond_with @role
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    flash[:notice] = 'Role was successfully updated.' if @role.update role_params
    respond_with @role
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_with @role, location: roles_path
  end

  protected

  def find_role
    @role = Role.find(params[:id])
    authorize @role
  end

  def find_roles
    authorize Role
    @roles = policy_scope(Role)
  end

  def role_params
    params.require(:role).permit :name, :write_entries, :add_lost_and_found, :admin_duty_board,
                                 :admin_radios, :admin_schedule, :admin_users,
                                 :assign_duty_board_slots, :assign_radios, :assign_shifts,
                                 :modify_lost_and_found, :read_hidden_entries,
                                 :make_hidden_entries, :read_audits, :rw_secure
  end
end
