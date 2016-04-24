# == Schema Information
#
# Table name: radio_assignment_audits
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  state         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  department_id :integer
#

class RadioAssignmentAuditsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  # GET /radio_assignment_audits
  # GET /radio_assignment_audits.json
  def index
    @radio_assignment_audits = RadioAssignmentAudit.all
  end
end
