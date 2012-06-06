class RadioAssignmentsController < ApplicationController
  before_filter :can_assign_radios?

  # POST /radio_assignments
  # POST /radio_assignments.json
  def create
    @radio_assignment             = RadioAssignment.new(params[:radio_assignment])
    @radio_assignment.radio.state = "out"
    respond_to do |format|
      if  @radio_assignment.save and
          @radio_assignment.radio.save and
          RadioAssignmentAudit.audit_checkout(@radio_assignment, current_user)
        format.html { redirect_to radios_url, notice: 'Radio assignment was successfully created.' }
        format.json { render json: @radio_assignment, status: :created, location: @radio_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @radio_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radio_assignments/1
  # DELETE /radio_assignments/1.json
  def destroy
    @radio_assignment = RadioAssignment.find(params[:id])
    @radio_assignment.checkin current_user

    respond_to do |format|
      format.html { redirect_to radios_url }
      format.json { head :ok }
    end
  end
end
