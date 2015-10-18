class DutyBoardAssignmentsController < ApplicationController
  layout 'duty_board'
  respond_to :html, :json

  before_action :get_slot
  before_action :create_assignment, only: [:create]
  load_and_authorize_resource

  def create
    @duty_board_assignment.save
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  def update
    @duty_board_assignment.update_attributes(assignment_params)
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  def destroy
    @duty_board_assignment.destroy
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  protected

  def assignment_params
    params.require(:duty_board_slot_id)
    params.require(:duty_board_assignment).permit(:duty_board_slot_id, :name, :notes)
  end

  def create_assignment
    @duty_board_assignment = @duty_board_slot.build_duty_board_assignment(assignment_params)
  end

  def get_slot
    @duty_board_slot = DutyBoardSlot.find(params[:duty_board_slot_id])
    authorize! :read, @duty_board_slot
  end

  def get_slot_and_assignment
    get_slot
    @duty_board_assignment = params[:id].present? ? DutyBoardAssignment.find_by_id(params[:id]) : @duty_board_slot.build_duty_board_assignment
  end
end
