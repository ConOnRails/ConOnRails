# == Schema Information
#
# Table name: radio_assignment_audits
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  state         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  department_id :integer
#

class RadioAssignmentAuditsController < ApplicationController
  load_and_authorize_resource

  respond_to :html
end
