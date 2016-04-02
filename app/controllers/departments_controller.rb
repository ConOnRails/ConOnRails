class DepartmentsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_departments, only: :index

  respond_to :html, :json

  # POST /departments
  # POST /departments.json
  def create
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

  def department_params
    params.require(:department).permit :name, :radio_allotment, :radio_group_id, :volunteer_id
  end
end
