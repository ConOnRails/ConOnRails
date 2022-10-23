# frozen_string_literal: true

class VspsController < ApplicationController
  respond_to :html

  before_action :find_vsps, only: [:index]
  before_action :new_vsp, only: [:new]
  before_action :create_vsp, only: [:create]
  before_action :find_vsp, only: %i[edit update]

  def index; end
  def new; end
  def edit; end

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
    authorize @vsp
  end

  def find_vsps
    @people  = policy_scope(Vsp).people
    @parties = policy_scope(Vsp).parties
    authorize @people
    authorize @parties
  end

  def find_vsp
    @vsp = Vsp.find params[:id]
    authorize @vsp
  end

  def new_vsp
    @vsp = Vsp.new
    authorize @vsp
  end

  def vsp_params
    params.require(:vsp).permit :name, :notes, :party
  end
end
