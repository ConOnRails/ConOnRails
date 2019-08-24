# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  realname        :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  long_name = 'a' * 33
  long_real_name = 'a' * 65
  short_password = 'a' * 4
  long_password = 'a' * 33
  bad_name = "a&%T@%< \003>s elknart" # Should fail for space, printable specials, and control-C
  bad_password = "a&%T@%< \003>s elknart" # Should fail for control-C
  good_password = 'zogity123*%^! 42'

  def failure_is_good(input_attributes)
    user = if input_attributes == {}
             User.new
           else
             User.new(input_attributes)
           end

    assert user.invalid?
  end

  setup do
    @input_attributes = {
      username: 'uncle-mikey',
      realname: 'Mi Key',
      password: good_password,
      password_confirmation: good_password
    }
  end

  test 'user attributes must not be empty' do
    empty = {}
    failure_is_good empty
  end

  test 'create a new user' do
    assert User.new(@input_attributes).valid?
  end

  test "user's name should be unique" do
    User.create!(@input_attributes)
    failure_is_good @input_attributes
  end

  test 'username should not be longer than 32 characters' do
    @input_attributes[:username] = long_name
    failure_is_good @input_attributes
  end

  test 'realname should not be longer than 64 characters' do
    @input_attributes[:realname] = long_real_name
    failure_is_good @input_attributes
  end

  test 'username should only contain alphanumerics and underscores' do
    @input_attributes[:username] = bad_name
    failure_is_good @input_attributes
  end

  test 'passwords have to match' do
    @input_attributes[:password_confirmation] = short_password
    failure_is_good @input_attributes
  end

  test 'passwords have to be at least 6 characters' do
    @input_attributes[:password] = short_password
    @input_attributes[:password_confirmation] = short_password
    failure_is_good @input_attributes
  end

  test "passwords shouldn't be more than 32 characters" do
    @input_attributes[:password] = long_password
    @input_attributes[:password_confirmation] = long_password
    failure_is_good @input_attributes
  end

  test 'passwords should only contain alphanumerics underscores and some printable specials' do
    @input_attributes[:password] = bad_password
    @input_attributes[:password_confirmation] = bad_password
    failure_is_good @input_attributes
  end

  test 'can authenticate user' do
    user = User.create!(@input_attributes)
    assert user.authenticate good_password
  end

  test "wrong passwords don't authenticate" do
    user = User.create!(@input_attributes)
    assert user.authenticate(short_password) == false
  end

  context '#has_role?' do
    setup do
      @user = User.create!(@input_attributes)
      role = FactoryBot.create(:role)
      @user.roles << role
    end

    should 'return true if appropriate' do
      assert @user.has_role? 'peon'
      assert @user.has_role? 'peon', 'llama'
    end
    should 'return false if appropriate' do
      assert @user.has_role?('god') == false
    end
  end
end
