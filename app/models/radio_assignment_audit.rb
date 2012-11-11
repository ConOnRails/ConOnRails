class RadioAssignmentAudit < ActiveRecord::Base

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
    attr = a.attributes
    attr[:user] = u
    attr[:state] = s
    RadioAssignmentAudit.create! attr
  end
end
