# frozen_string_literal: true

class ConventionsController < ApplicationController
  respond_to :html

  before_action :set_conventions, only: [:index]
  before_action :set_convention, only: %i[show edit update]
  before_action :build_convention, only: [:create]

  def index; end
  def show; end

  def new
    @convention = Convention.new
    authorize @convention
  end

  # GET /conventions/new
  # GET /conventions/new.json
  def edit; end

  # POST /conventions
  # POST /conventions.json
  def create
    flash.now[:notice] = 'Convention was successfully created.' if @convention.save
    respond_with @convention, location: :conventions
  end

  # PUT /conventions/1
  # PUT /conventions/1.json
  def update
    if @convention.update convention_params
      flash.now[:notice] =
        'Convention was successfully updated.'
    end
    respond_with @convention, location: :conventions
  end

  protected

  def set_conventions
    @q = policy_scope(Convention).ransack params[:q]
    @q.sorts = ['start_date desc'] if @q.sorts.empty?
    @conventions = @q.result.page(params[:page])
    authorize @conventions
  end

  def set_convention
    @convention = Convention.find params[:id]
    authorize @convention
  end

  def build_convention
    @convention = Convention.new convention_params
    authorize @convention
  end

  def convention_params
    params.require(:convention).permit :end_date, :name, :start_date
  end
end
