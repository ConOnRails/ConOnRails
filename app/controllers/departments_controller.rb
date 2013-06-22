class DepartmentsController < ApplicationController
  before_filter :can_write_entries?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_departments, only: :index
  before_filter :find_department, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /departments
  # GET /departments.json
  def index
    respond_with @departments
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    respond_with @department
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new
    respond_with @department
  end

  # GET /departments/1/edit
  def edit
    respond_with @department
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(params[:department])
    flash[:notice] = 'Department was successfully created.' if @department.save
    respond_with @department
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    flash[:notice] = 'Department was successfully updated.' if @department.update_attributes(params[:department])
    respond_with @department
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_with @department
  end

  protected

  def find_departments
    @q           = Department.search params[:q]
    @departments = @q.result.page(params[:page])
  end

  def find_department
    @department = Department.find(params[:id])
  end
end
