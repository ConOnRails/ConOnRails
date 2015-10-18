class ConventionsController < ApplicationController
  respond_to :html

  before_filter :set_conventions, only: [:index]
  load_and_authorize_resource

  # GET /conventions/new
  # GET /conventions/new.json
  def new
    @convention = Convention.new
  end

  # POST /conventions
  # POST /conventions.json
  def create
    flash[:notice] = 'Convention was successfully created.' if @convention.save
    respond_with @convention, location: :conventions
  end

  # PUT /conventions/1
  # PUT /conventions/1.json
  def update
    flash[:notice] = 'Convention was successfully updated.' if @convention.update_attributes convention_params
    respond_with @convention, location: :conventions
  end

  protected

  def set_conventions
    @q = Convention.search params[:q]
    @q.sorts = ['start_date desc'] if @q.sorts.empty?
    @conventions = @q.result.page(params[:page])
  end

  def set_convention
    @convention = Convention.find params[:id]
  end

  def build_convention
    @convention = Convention.new convention_params
  end

  def convention_params
    params.require(:convention).permit :end_date, :name, :start_date
  end

end
