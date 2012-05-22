class RadioAssignmentAuditsController < ApplicationController
  before_filter :can_admin_radios?

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    @radio_assignment_audits = RadioAssignmentAudit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radio_assignment_audits }
    end
  end
  #
  ## GET /radio_assignment_audits/1
  ## GET /radio_assignment_audits/1.json
  #def show
  #  @radio_assignment_audit = RadioAssignmentAudit.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @radio_assignment_audit }
  #  end
  #end
  #
  ## GET /radio_assignment_audits/new
  ## GET /radio_assignment_audits/new.json
  #def new
  #  @radio_assignment_audit = RadioAssignmentAudit.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @radio_assignment_audit }
  #  end
  #end
  #
  ## GET /radio_assignment_audits/1/edit
  #def edit
  #  @radio_assignment_audit = RadioAssignmentAudit.find(params[:id])
  #end
  #
  ## POST /radio_assignment_audits
  ## POST /radio_assignment_audits.json
  #def create
  #  @radio_assignment_audit = RadioAssignmentAudit.new(params[:radio_assignment_audit])
  #
  #  respond_to do |format|
  #    if @radio_assignment_audit.save
  #      format.html { redirect_to @radio_assignment_audit, notice: 'Radio assignment audit was successfully created.' }
  #      format.json { render json: @radio_assignment_audit, status: :created, location: @radio_assignment_audit }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @radio_assignment_audit.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PUT /radio_assignment_audits/1
  ## PUT /radio_assignment_audits/1.json
  #def update
  #  @radio_assignment_audit = RadioAssignmentAudit.find(params[:id])
  #
  #  respond_to do |format|
  #    if @radio_assignment_audit.update_attributes(params[:radio_assignment_audit])
  #      format.html { redirect_to @radio_assignment_audit, notice: 'Radio assignment audit was successfully updated.' }
  #      format.json { head :ok }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @radio_assignment_audit.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /radio_assignment_audits/1
  ## DELETE /radio_assignment_audits/1.json
  #def destroy
  #  @radio_assignment_audit = RadioAssignmentAudit.find(params[:id])
  #  @radio_assignment_audit.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to radio_assignment_audits_url }
  #    format.json { head :ok }
  #  end
  #end
end
