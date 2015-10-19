# == Schema Information
#
# Table name: roles
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  write_entries           :boolean
#  read_hidden_entries     :boolean
#  add_lost_and_found      :boolean
#  modify_lost_and_found   :boolean
#  admin_radios            :boolean
#  assign_radios           :boolean
#  admin_users             :boolean
#  admin_schedule          :boolean
#  assign_shifts           :boolean
#  assign_duty_board_slots :boolean
#  admin_duty_board        :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  make_hidden_entries     :boolean          default(FALSE)
#  rw_secure               :boolean          default(FALSE)
#  read_audits             :boolean          default(FALSE)
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should have_many(:sections).through :section_roles
  should validate_presence_of :name
  should validate_uniqueness_of :name

  LongName = 'a' * 33
  BadName = "a&%T@%{ \003} elknart" # Should fail for printable specials, and control-C
  
  setup do
    @empty_role = Role.new
  end
  
  test "role flags should default to false" do
    assert !@empty_role.write_entries?
    assert !@empty_role.read_hidden_entries?
    assert !@empty_role.add_lost_and_found?
    assert !@empty_role.modify_lost_and_found?
    assert !@empty_role.admin_radios?
    assert !@empty_role.admin_users?
    assert !@empty_role.admin_schedule?
    assert !@empty_role.assign_shifts?
    assert !@empty_role.assign_duty_board_slots?
    assert !@empty_role.admin_duty_board?
  end
    
  test "roles must have names" do
    role = Role.create
    assert role.invalid?
  end
  
  test "role names should be unique" do
    role1 = Role.create name: "Fish"
    role2 = Role.create name: "Fish"
    
    assert role2.invalid?
  end
  
  test "role names should be 32 characters or less" do
    role = Role.create name: LongName
    assert role.invalid?
  end
  
  test "role names should not contain printable-specials or control characters" do
    role = Role.create name: BadName
    assert role.invalid?
  end

end
