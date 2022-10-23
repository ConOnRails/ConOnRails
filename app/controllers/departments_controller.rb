# frozen_string_literal: true

class DepartmentsController < ApplicationController
  before_action :find_departments, only: :index
  before_action :find_department, only: %i[show edit update destroy]

  respond_to :html, :json

  def index; end
  def show; end

  def new
    @department = Department.new
    authorize @department
  end

  # GET /departments/new
  # GET /departments/new.json
  def edit; end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new department_params
    authorize @department

    flash.now[:notice] = 'Department was successfully created.' if @department.save
    respond_with @department
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    if @department.update department_params
      flash.now[:notice] =
        'Department was successfully updated.'
    end
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
    @q           = policy_scope(Department).ransack top_params[:q]
    @departments = @q.result.page(top_params[:page])
    authorize @departments
  end

  def find_department
    @department = Department.find(top_params[:id])
    authorize @department
  end

  def top_params
    params.permit(:id, :page, :q)
  end

  def department_params
    params.require(:department).permit :name, :radio_allotment, :radio_group_id, :volunteer_id
  end
end
