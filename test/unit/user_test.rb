require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def failure_is_good( input_attributes )
    user = nil
    if input_attributes == {}
      user = User.new
    else
      user = User.create( input_attributes )
    end

    assert user.invalid?
  end
  
  setup do
    @input_attributes = {
        name: "mikey",
        realname: "Mi Key",
        password: "zog",
        password_confirmation: "zog",
    }
  end
  
  test "user attributes must not be empty" do
    empty = {}
    failure_is_good empty
  end
  
  test "create a new user" do
    User.create! @input_attributes
  end
    
  test "user's name should be unique" do
    user1 = User.create!(@input_attributes)
    failure_is_good @input_attributes
  end
  
  test "username should not be longer than 32 characters" do
    long_name_is_long = @input_attributes
    long_name_is_long[:name] = 'a' * 33
    failure_is_good long_name_is_long
  end
  
  test "realname should not be longer than 64 characters" do
    long_name_is_long = @input_attributes
    long_name_is_long[:realname] = 'a' * 65
    failure_is_good long_name_is_long
  end
  
  test "username should only contain alphanumerics and underscores" do
    bad_username_is_bad = @input_attributes
    bad_username_is_bad[:name] = "a&%T@%{ \003} elknart"
    failure_is_good bad_username_is_bad
  end
end
