# frozen_string_literal: true

# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#
# Indexes
#
#  index_roles_users_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#

require 'test_helper'

class RolesUsersTest < ActiveSupport::TestCase
  setup do
    @user1 = FactoryBot.create :user
    @user2 = FactoryBot.create :user
    @role1 = FactoryBot.create :write_entries_role
    @role2 = FactoryBot.create :role
  end

  def setup_roles
    @user1.roles << @role1
    @user2.roles << @role2
  end

  test 'can associate user with role' do
    @user1.roles << @role1
    assert_equal 1, @user1.roles.count
    assert_equal 1, @role1.users.count
  end

  test 'can associate multiple roles with user' do
    @user1.roles << @role1
    @user1.roles << @role2
    assert_equal 2, @user1.roles.count
    assert_equal 1, @role1.users.count
    assert_equal 1, @role2.users.count
  end

  test 'can associate multiple users with role' do
    @user1.roles << @role1
    @user2.roles << @role1
    assert_equal 2, @role1.users.count
    assert_equal 1, @user1.roles.count
    assert_equal 1, @user2.roles.count
  end

  test 'can find write_entries permission in user roles' do
    setup_roles
    assert_predicate @user1, :write_entries?
  end

  test 'can find absence of write_entries permission in user roles' do
    setup_roles
    assert_not @user2.write_entries?
  end
end
