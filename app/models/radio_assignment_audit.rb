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

class RadioAssignmentAudit < ActiveRecord::Base
  has_paper_trail

  belongs_to :radio
  belongs_to :volunteer
  belongs_to :department
  belongs_to :user
  validates_presence_of :radio
  validates_presence_of :department
  validates_presence_of :user

  def RadioAssignmentAudit.audit_checkin( radio_assignment, user )
    RadioAssignmentAudit.new_record radio_assignment, user, :in
  end


  def RadioAssignmentAudit.audit_checkout( radio_assignment, user )
    RadioAssignmentAudit.new_record radio_assignment, user, :out
  end

  def RadioAssignmentAudit.audit_retirement( radio_assignment, user )
    RadioAssignmentAudit.new_record radio_assignment, user, :retired
  end

protected
  def RadioAssignmentAudit.new_record( a, u, s )
    attr = a.attributes.reject { |k, v| [:created_at, :updated_at, :id].include? k.to_sym }
    attr[:user_id] = u.id
    attr[:state] = s
    RadioAssignmentAudit.create! attr
  end
end
