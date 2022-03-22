# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id                      :integer          not null, primary key
#  add_lost_and_found      :boolean
#  admin_duty_board        :boolean
#  admin_radios            :boolean
#  admin_schedule          :boolean
#  admin_users             :boolean
#  assign_duty_board_slots :boolean
#  assign_radios           :boolean
#  assign_shifts           :boolean
#  make_hidden_entries     :boolean          default("false")
#  modify_lost_and_found   :boolean
#  name                    :string
#  read_audits             :boolean          default("false")
#  read_hidden_entries     :boolean
#  rw_secure               :boolean          default("false")
#  write_entries           :boolean
#  created_at              :datetime
#  updated_at              :datetime
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  long_name = 'a' * 33
  bad_name = "a&%T@%< \003>s elknart" # Should fail for printable specials, and control-C

  setup do
    @empty_role = Role.new
  end

  test 'role flags should default to false' do
    assert_not @empty_role.write_entries?
    assert_not @empty_role.read_hidden_entries?
    assert_not @empty_role.add_lost_and_found?
    assert_not @empty_role.modify_lost_and_found?
    assert_not @empty_role.admin_radios?
    assert_not @empty_role.admin_users?
    assert_not @empty_role.admin_schedule?
    assert_not @empty_role.assign_shifts?
    assert_not @empty_role.assign_duty_board_slots?
    assert_not @empty_role.admin_duty_board?
  end

  test 'roles must have names' do
    role = Role.create
    assert role.invalid?
  end

  test 'role names should be unique' do
    Role.create name: 'Fish'
    role2 = Role.create name: 'Fish'

    assert role2.invalid?
  end

  test 'role names should be 32 characters or less' do
    role = Role.create name: long_name
    assert role.invalid?
  end

  test 'role names should not contain printable-specials or control characters' do
    role = Role.create name: bad_name
    assert role.invalid?
  end
  # test "the truth" do
  #   assert true
  # end
end
