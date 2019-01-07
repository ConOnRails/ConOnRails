class DutyBoardGroupsController < ApplicationController
  before_filter :can_admin_duty_board?

  respond_to :html, :json

  def index
    @duty_board_groups = DutyBoardGroup.order(:row, :column)
  end

  def new
    @duty_board_group = DutyBoardGroup.new
  end

  def create
    @duty_board_group = DutyBoardGroup.new duty_board_group_params
    flash[:notice] = 'Duty board group created successfully' if @duty_board_group.save
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def edit
    @duty_board_group = DutyBoardGroup.find params[:id]
  end

  def update
    @duty_board_group = DutyBoardGroup.find params[:id]
    flash[:notice] = 'Duty board group updated successfully' if @duty_board_group.update_attributes duty_board_group_params
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def destroy
    @duty_board_group = DutyBoardGroup.find params[:id]
    @duty_board_group.destroy
    respond_with @duty_board_group
  end

  protected

  def duty_board_group_params
    params.require(:duty_board_group).permit :name, :row, :column
  end
end
