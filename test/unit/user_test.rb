require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  setup do
    @input_attributes = {
        name: "mikey",
        realname: "Mi Key",
        password: "zog",
        password_confirmation: "zog",
    }
  end
  
  test "user attributes must not be empty" do
    user = User.new
    assert user.invalid?
    assert user.errors[:name].any?
  end
  
  test "create a new user" do
    User.create!(@input_attributes)
  end
    
  test "user's name should be unique" do
    user1 = User.create!(@input_attributes)
    user2 = User.create(@input_attributes)
    assert user2.invalid?, "This should have failed"
    assert user2.errors[:name].any?
  end
  
  # test "the truth" do
  #   assert true
  # end
end
