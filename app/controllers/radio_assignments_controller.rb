class RadioAssignmentsController < ApplicationController
  respond_to :html, :json, only: :destroy
  respond_to :js, only: [:create, :update]

  before_filter :can_assign_radios?
  before_filter :find_assignment

  # POST /radio_assignments
  # POST /radio_assignments.json
  def create
    @radio_assignment = RadioAssignment.checkout(radio_assignment_params, current_user)
    respond_with do |format|
      if @radio_assignment.valid?
        format.js { render 'success' }
      else
        format.js { render 'error' }
      end
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

  def find_assignment
    @radio_assignment = RadioAssignment.find(params[:id]) if params[:id]
  end

  def radio_assignment_params
    params.require(:radio_assignment).permit(:radio_id, :volunteer_id, :department_id)
  end
end
