# frozen_string_literal: true

class VspsController < ApplicationController
  respond_to :html

  before_action :reject_peons
  before_action :find_vsps, only: [:index]
  before_action :new_vsp, only: [:new]
  before_action :create_vsp, only: [:create]
  before_action :find_vsp, only: %i[edit update]

  def create
    flash[:notice] = 'VSP created successfully!' if @vsp.save
    respond_with @vsp, location: vsps_path
  end

  def update
    flash[:notice] = 'VSP updated successfully!' if @vsp.update vsp_params
    respond_with @vsp, location: vsps_path
  end

  protected

  def create_vsp
    @vsp = Vsp.new vsp_params
  end

  def find_vsps
    @people  = Vsp.people
    @parties = Vsp.parties
  end

  def find_vsp
    @vsp = Vsp.find params[:id]
  end

  def new_vsp
    @vsp = Vsp.new
  end

  def reject_peons
    redirect_to root_url unless current_user.can_read_audits?
  end

  def vsp_params
    params.require(:vsp).permit :name, :notes, :party
  end
end
