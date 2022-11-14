# frozen_string_literal: true

class DutyBoardGroupsController < ApplicationController
  respond_to :html, :json

  def index
    @duty_board_groups = policy_scope(DutyBoardGroup).order(:row, :column)
    authorize @duty_board_groups
  end

  def new
    @duty_board_group = DutyBoardGroup.new
    authorize @duty_board_group
  end

  def edit
    @duty_board_group = DutyBoardGroup.find params[:id]
    authorize @duty_board_group
  end

  def create
    @duty_board_group = DutyBoardGroup.new duty_board_group_params
    authorize @duty_board_group

    flash.now[:notice] = 'Duty board group created successfully' if @duty_board_group.save
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def update
    @duty_board_group = DutyBoardGroup.find params[:id]
    authorize @duty_board_group

    if @duty_board_group.update duty_board_group_params
      flash.now[:notice] =
        'Duty board group updated successfully'
    end
    respond_with @duty_board_group, location: duty_board_groups_path
  end

  def destroy
    @duty_board_group = DutyBoardGroup.find params[:id]
    authorize @duty_board_group

    @duty_board_group.destroy
    respond_with @duty_board_group
  end

  protected

  def duty_board_group_params
    params.require(:duty_board_group).permit :name, :row, :column
  end
end
