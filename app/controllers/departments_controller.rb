class DepartmentsController < ApplicationController
  before_filter :find_departments, only: :index
  load_and_authorize_resource

  respond_to :html, :json

   # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new department_params
    flash[:notice] = 'Department was successfully created.' if @department.save
    respond_with @department
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    flash[:notice] = 'Department was successfully updated.' if @department.update_attributes department_params
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

  def department_params
    params.require(:department).permit :name, :radio_allotment, :radio_group_id, :volunteer_id
  end
end
