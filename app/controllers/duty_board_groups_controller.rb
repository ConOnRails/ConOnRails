class DutyBoardGroupsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  def index
    @duty_board_groups = @duty_board_groups.order(:row, :column)
  end

  def create
    flash[:notice] = 'Duty board group created successfully' if @duty_board_group.save
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def update
    flash[:notice] = 'Duty board group updated successfully' if @duty_board_group.update_attributes duty_board_group_params
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def destroy
    @duty_board_group.destroy
    respond_with @duty_board_group
  end

  protected

  def duty_board_group_params
    params.require(:duty_board_group).permit :name, :row, :column
  end

end
