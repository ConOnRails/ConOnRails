require 'test_helper'

class RadioAssignmentAuditTest < ActiveSupport::TestCase
  setup do
    @radio     = FactoryGirl.create :valid_blue_radio
    @volunteer = FactoryGirl.create :valid_volunteer
    @user      = FactoryGirl.create :user
  end

  # @param [string] method
  # @param [constant] state
  def can_create_audit( method, state )
    audit = nil
    assert_difference 'RadioAssignmentAudit.count' do
      audit = RadioAssignmentAudit.send( 'audit_' + method, @radio, @volunteer, @user )
    end

    assert_not_nil audit
    assert audit.valid?
    assert_equal state, audit.state
  end

  test "can create checkout audit" do
    can_create_audit( 'checkout', :out )
  end

  test "can create checkin audit" do
    can_create_audit( 'checkin', :in )
  end

  test "can create retirement audit" do
    can_create_audit( 'retirement', :retired )
  end



end
