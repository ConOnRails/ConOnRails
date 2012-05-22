class RadioAssignmentsController < ApplicationController
  before_filter :can_assign_radios?

  # GET /radio_assignments
  # GET /radio_assignments.json
  def index
    @radios = Radio.all
    @radio_assignments = RadioAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radio_assignments }
    end
  end

  # GET /radio_assignments/checkout
  # GET /radio_assignments/checkout.json
  def new
    @radio_assignment = RadioAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @radio_assignment }
    end
  end

  def checkin
    @radio_assignment = RadioAssignment.find params[:id]
  end

  # GET /radio_assignments/1/edit
  def edit
    @radio_assignment = RadioAssignment.find(params[:id])
  end

  # POST /radio_assignments
  # POST /radio_assignments.json
  def create
    @radio_assignment = RadioAssignment.new(params[:radio_assignment])

    respond_to do |format|
      if @radio_assignment.save and RadioAssignmentAudit.audit_checkout(@radio_assignment, current_user)
        format.html { redirect_to @radio_assignment, notice: 'Radio assignment was successfully created.' }
        format.json { render json: @radio_assignment, status: :created, location: @radio_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @radio_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radio_assignments/1
  # PUT /radio_assignments/1.json
  def update
    @radio_assignment = RadioAssignment.find(params[:id])

    respond_to do |format|
      if @radio_assignment.update_attributes(params[:radio_assignment])
        format.html { redirect_to @radio_assignment, notice: 'Radio assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @radio_asssignment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /radio_assignments/1
  # DELETE /radio_assignments/1.json
  def destroy
    @radio_assignment = RadioAssignment.find(params[:id])
    @radio_assignment.destroy
    RadioAssignmentAudit.audit_checkin( @radio_assignment, current_user )

    respond_to do |format|
      format.html { redirect_to radio_assignments_url }
      format.json { head :ok }
    end
  end
end
