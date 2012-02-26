require 'test_helper'

class RolesUsersTest < ActiveSupport::TestCase
  fixtures :users, :roles
  setup do
    @user1 = User.find users :one
    @user2 = User.find users :two
    @role1 = Role.find roles :peon
    @role2 = Role.find roles :admin
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
    assert @user2.write_entries?
  end
  
  test "can find absence of write_entries permission in user roles" do
    setup_roles
    assert !@user1.write_entries?
  end

end
