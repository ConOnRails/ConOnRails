# frozen_string_literal: true

class DutyBoardAssignmentsController < ApplicationController
  layout 'duty_board'
  respond_to :html, :json

  before_action :get_slot_and_assignment, only: %i[new edit update destroy]
  before_action :get_slot, only: [:create]

  def create
    @duty_board_assignment = @duty_board_slot.build_duty_board_assignment(assignment_params)
    authorize @duty_board_assignment

    @duty_board_assignment.save!
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  def update
    @duty_board_assignment.update(assignment_params)
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

  def get_slot
    @duty_board_slot = DutyBoardSlot.find(params[:duty_board_slot_id])
  end

  def get_slot_and_assignment
    get_slot
    @duty_board_assignment = params[:id].present? ? DutyBoardAssignment.find_by(id: params[:id]) : @duty_board_slot.build_duty_board_assignment
    authorize @duty_board_assignment
  end
end
