# frozen_string_literal: true

class RadioAssignmentAuditsController < ApplicationController
  respond_to :html

  before_action :can_admin_radios?
  before_action :get_audits, only: :index

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    respond_to do |format|
      format.html
      format.csv { send_data RadioAssignmentAudit.all.to_csv }
    end
  end

  protected

  def get_audits
    @q = RadioAssignmentAudit.ransack params[:q]
    @radio_assignment_audits = @q.result.page params[:page]
  end
end
