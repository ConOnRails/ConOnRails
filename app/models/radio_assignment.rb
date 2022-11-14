# frozen_string_literal: true

# == Schema Information
#
# Table name: radio_assignments
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  department_id :integer
#  radio_id      :integer
#  volunteer_id  :integer
#
# Indexes
#
#  index_radio_assignments_on_radio_id  (radio_id) UNIQUE
#

class DepartmentAllotmentChecker < ActiveModel::Validator
  def validate(record)
    if record.department.present? &&
       RadioAssignment.department_count(record.department_id) + 1 >
       record.department.radio_allotment
      record.errors.add(:department, "All of this department's radios are allotted")
      record.errors.add(:radio, "All of this department's radios are allotted")
    end
  end
end

class RadioAssignment < ApplicationRecord
  has_paper_trail

  belongs_to :radio
  belongs_to :volunteer
  belongs_to :department

  validates :radio_id, uniqueness: true
  validates :volunteer_id, uniqueness: true,
                           unless: lambda { |x|
                             x.volunteer.present? &&
                               x.volunteer.can_have_multiple_radios?
                           }
  validates_with DepartmentAllotmentChecker, message: "All of this department's radios are allotted"

  def self.department_count(dept_id)
    RadioAssignment.where(department_id: dept_id).count
  end

  def self.checkout(params, user)
    assignment = RadioAssignment.new radio_id: params[:radio_id],
                                     volunteer_id: params[:volunteer_id],
                                     department_id: params[:department_id]
    if assignment.valid?
      assignment.radio.state = 'out'
      RadioAssignmentAudit.audit_checkout assignment, user
    end
    assignment
  end

  def checkin(user)
    RadioAssignmentAudit.audit_checkin(self, user)
    destroy

    return unless destroyed?

    radio.update(state: 'in')
  end

  def transfer(params, user)
    if update(volunteer_id: params[:volunteer_id], department_id: params[:department_id])
      RadioAssignmentAudit.audit_checkout(self, user)
    end
    self
  end
end
