class DepartmentAllotmentChecker < ActiveModel::Validator
  def validate(record)
     if RadioAssignment.department_count(record.department.id) + 1 >
         record.department.radio_allotment
       record.errors[:department] << "All of this department's radios are allotted"
     end
  end
end

class RadioAssignment < ActiveRecord::Base
  belongs_to :radio
  belongs_to :volunteer
  belongs_to :department
  validates_presence_of :radio, :volunteer, :department
  validates_uniqueness_of :radio_id # Only one instance of a radio checkout at a time!
  validates_with DepartmentAllotmentChecker

  def RadioAssignment.department_count(dept_id)
    RadioAssignment.where( department_id: dept_id ).count
  end

  def checkin( user )
    RadioAssignmentAudit.audit_checkin(self, user)
    self.radio.state = "in"
    self.radio.save
    destroy
  end
end
