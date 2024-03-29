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

require 'test_helper'

class RadioAssignmentAuditTest < ActiveSupport::TestCase
  setup do
    @assignment = FactoryBot.build :valid_radio_assignment
    @user = FactoryBot.create :user
  end

  # @param [string] method
  # @param [constant] state
  def can_create_audit(method, state)
    audit = nil
    assert_difference 'RadioAssignmentAudit.count' do
      audit = RadioAssignmentAudit.send("audit_#{method}", @assignment, @user)
    end

    assert_not_nil audit
    assert_predicate audit, :valid?
    assert_equal state, audit.state
  end

  test 'can create checkout audit' do
    can_create_audit('checkout', 'out')
  end

  test 'can create checkin audit' do
    can_create_audit('checkin', 'in')
  end

  test 'can create retirement audit' do
    can_create_audit('retirement', 'retired')
  end
end
