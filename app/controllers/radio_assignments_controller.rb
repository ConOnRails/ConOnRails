class RadioAssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :can_assign_radios?
  before_filter :find_assignment


  # POST /radio_assignments
  # POST /radio_assignments.json
  def create
    @radio_assignment = RadioAssignment.checkout(params[:radio_assignment], current_user)
    respond_with @radio_assignment, location: radios_url
  end

  def update
    @radio_assignment.transfer params[:radio_assignment], current_user
    respond_with @radio_assignment, location: radios_url
  end

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

  def find_assignment
    @radio_assignment = RadioAssignment.find(params[:id]) if params[:id]
  end
end
