# frozen_string_literal: true

# == Schema Information
#
# Table name: radio_assignment_audits
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  state         :string
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  department_id :integer
#
class RadioAssignmentAudit < ApplicationRecord
  has_paper_trail

  paginates_per 30

  belongs_to :radio
  belongs_to :volunteer
  belongs_to :department
  belongs_to :user

  def self.audit_checkin(radio_assignment, user)
    RadioAssignmentAudit.new_record radio_assignment, user, :in
  end

  def self.audit_checkout(radio_assignment, user)
    RadioAssignmentAudit.new_record radio_assignment, user, :out
  end

  def self.audit_retirement(radio_assignment, user)
    RadioAssignmentAudit.new_record radio_assignment, user, :retired
  end

  def self.to_csv
    attributes = %w[id radio_name volunteer_id volunteer_name state created_at updated_at admin_id
                    admin_name department_name]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |audit|
        csv << attributes.map { |attr| audit.send(attr) }
      end
    end
  end

  def radio_name
    radio.try(:name) || ''
  end

  def volunteer_name
    volunteer.try(:name) || ''
  end

  def admin_id
    user.try(:id) || ''
  end

  def admin_name
    user.try(:realname) || ''
  end

  def department_name
    department.try(:name) || ''
  end

  def self.new_record(audit, user, state)
    attr = audit.attributes.reject { |k, _v| %i[created_at updated_at id].include? k.to_sym }
    attr[:user_id] = user.id
    attr[:state] = state
    RadioAssignmentAudit.create! attr
  end
end
