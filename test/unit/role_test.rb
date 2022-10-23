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
    %i[
      write_entries? read_hidden_entries? add_lost_and_found? modify_lost_and_found?
      admin_radios? admin_users? admin_schedule? assign_shifts? assign_duty_board_slots?
      admin_duty_board?
    ].each do |flag|
      assert_not @empty_role.send flag
    end
  end

  test 'roles must have names' do
    role = Role.create
    assert_predicate role, :invalid?
  end

  test 'role names should be unique' do
    Role.create name: 'Fish'
    role2 = Role.create name: 'Fish'

    assert_predicate role2, :invalid?
  end

  test 'role names should be 32 characters or less' do
    role = Role.create name: long_name
    assert_predicate role, :invalid?
  end

  test 'role names should not contain printable-specials or control characters' do
    role = Role.create name: bad_name
    assert_predicate role, :invalid?
  end
  # test "the truth" do
  #   assert true
  # end
end
