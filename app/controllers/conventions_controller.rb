class ConventionsController < ApplicationController
  respond_to :html

  before_filter :can_read_audits?
  before_filter :set_conventions, only: [:index]
  before_filter :set_convention, only: [:show, :edit, :update]
  before_filter :build_convention, only: [:new, :create]

  # GET /conventions
  # GET /conventions.json
  def index
  end

  # GET /conventions/1
  # GET /conventions/1.json
  def show
  end

  # GET /conventions/new
  # GET /conventions/new.json
  def new
  end

  # GET /conventions/1/edit
  def edit
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
    flash[:notice] = 'Convention was successfully updated.' if @convention.update_attributes(params[:convention])
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
    @convention = Convention.new params[:convention]
  end

end
