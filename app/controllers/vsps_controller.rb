class VspsController < ApplicationController
  respond_to :html

  before_filter :reject_peons
  before_filter :find_vsps, only: [:index]
  before_filter :find_vsp, only: [:edit, :update]

  def index
  end

  def new
    @vsp = Vsp.new
  end

  def create
    @vsp = Vsp.create params[:vsp]
    respond_with @vsp, location: vsps_path
  end

  def update
    if @vsp.update_attributes params[:vsp]
      respond_with @vsp, location: vsps_path
    else
      respond_with @vsp
    end
  end

  def edit

  end

  protected

  def find_vsps
    @people  = Vsp.people
    @parties = Vsp.parties
  end

  def find_vsp
    @vsp = Vsp.find params[:id]
  end

  def reject_peons
    redirect_to root_url unless current_user.can_read_audits?
  end
end
