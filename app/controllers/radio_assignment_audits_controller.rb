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
end
