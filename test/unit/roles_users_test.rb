# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#

require 'test_helper'

class RolesUsersTest < ActiveSupport::TestCase
  setup do
    @user1 = FactoryGirl.create :user
    @user2 = FactoryGirl.create :user
    @role1 = FactoryGirl.create :typical_role
    @role2 = FactoryGirl.create :role
  end

  def setup_roles
    @user1.roles << @role1
    @user2.roles << @role2
  end

  test "can associate user with role" do
    @user1.roles << @role1
    assert_equal 1, @user1.roles.count
    assert_equal 1, @role1.users.count
  end

  test "can associate multiple roles with user" do
    @user1.roles << @role1
    @user1.roles << @role2
    assert_equal 2, @user1.roles.count
    assert_equal 1, @role1.users.count
    assert_equal 1, @role2.users.count
  end

  test "can associate multiple users with role" do
    @user1.roles << @role1
    @user2.roles << @role1
    assert_equal 2, @role1.users.count
    assert_equal 1, @user1.roles.count
    assert_equal 1, @user2.roles.count
  end

  test "can find write_entries permission in user roles" do
    setup_roles
    assert @user1.can_assign_duty_board_slots?
  end
  
  test "can find absence of write_entries permission in user roles" do
    setup_roles
    assert !@user2.can_assign_duty_board_slots?
  end

end
