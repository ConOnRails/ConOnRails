class RadioAssignmentAuditsController < ApplicationController
  respond_to :html

  before_filter :can_admin_radios?

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    @radio_assignment_audits = RadioAssignmentAudit.all
  end
end
