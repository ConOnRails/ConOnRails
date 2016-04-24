# == Schema Information
#
# Table name: radio_assignments
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#  department_id :integer
#

class RadioAssignmentsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json, only: :destroy
  respond_to :js, only: [:create, :update]

  # POST /radio_assignments
  # POST /radio_assignments.json
  def create
    @radio_assignment = RadioAssignment.checkout(radio_assignment_params, current_user)
    @radio_assignment.transaction do |t|
      respond_with do |format|
        if @radio_assignment.save && @radio_assignment.radio.save
          format.js { render 'success' }
        else
          format.js { render 'error' }
        end
      end

      raise ActiveRecord::Rollback unless @radio_assignment.persisted? && @radio_assignment.radio.persisted?
    end
  end

  def update
    @radio_assignment = @radio_assignment.transfer radio_assignment_params, current_user
    respond_with do |format|
      if @radio_assignment.valid?
        format.js { render 'success' }
      else
        format.js { render 'error' }
      end
    end  end

# DELETE /radio_assignments/1
# DELETE /radio_assignments/1.json
  def destroy
    @radio_assignment.checkin current_user

    respond_to do |format|
      format.html { redirect_to radios_url }
      format.json { head :ok }
    end
  end

  protected

  def radio_assignment_params
    params.require(:radio_assignment).permit(:radio_id, :volunteer_id, :department_id)
  end
end
