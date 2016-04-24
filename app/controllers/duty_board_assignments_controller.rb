# == Schema Information
#
# Table name: duty_board_assignments
#
#  id                 :integer          not null, primary key
#  duty_board_slot_id :integer
#  notes              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(255)
#  string             :string(255)
#

class DutyBoardAssignmentsController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :duty_board_slot

  layout 'duty_board'
  respond_to :html, :json

  def create
    @duty_board_assignment = @duty_board_slot.build_duty_board_assignment(duty_board_assignment_params)
    @duty_board_assignment.save!
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  def update
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  def destroy
    @duty_board_assignment.destroy
    respond_with @duty_board_assignment, location: duty_board_index_path
  end

  protected

  def duty_board_assignment_params
    params.require(:duty_board_slot_id)
    params.require(:duty_board_assignment).permit(:duty_board_slot_id, :name, :notes)
  end
end
