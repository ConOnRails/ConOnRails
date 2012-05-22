class RadioAssignmentAudit < ActiveRecord::Base
  belongs_to :radio
  belongs_to :volunteer
  belongs_to :user

  def RadioAssignmentAudit.audit_checkin( radio, volunteer, user )
    RadioAssignmentAudit.create! radio: radio, volunteer: volunteer, state: :in, user: user
  end

  def RadioAssignmentAudit.audit_checkout( radio, volunteer, user )
    RadioAssignmentAudit.create! radio: radio, volunteer: volunteer, state: :out, user: user
  end

  def RadioAssignmentAudit.audit_retirement( radio, dummy, user )
    RadioAssignmentAudit.create! radio: radio, volunteer: nil, state: :retired, user: user
  end
end
