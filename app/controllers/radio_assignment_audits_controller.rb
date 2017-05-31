class RadioAssignmentAuditsController < ApplicationController
  respond_to :html

  before_filter :can_admin_radios?

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    @radio_assignment_audits = RadioAssignmentAudit.all

    respond_to do |format|
    	format.html
    	format.csv { send_data @radio_assignment_audits.to_csv }
    end
  end

end