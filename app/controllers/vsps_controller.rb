class VspsController < ApplicationController
  respond_to :html

  before_filter :reject_peons
  before_filter :find_vsps, only: [:index]
  before_filter :new_vsp, only: [:new]
  before_filter :create_vsp, only: [:create]
  before_filter :find_vsp, only: [:edit, :update]

  def create
    flash[:notice] = 'VSP created successfully!' if @vsp.save
    respond_with @vsp, location: vsps_path
  end

  def update
    flash[:notice] = 'VSP updated successfully!' if @vsp.update_attributes vsp_params
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
