class RadioAssignmentAuditsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    @radio_assignment_audits = RadioAssignmentAudit.all
  end
end
