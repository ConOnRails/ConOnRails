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
  LongName = 'a' * 33
  LongRealName = 'a' * 65
  ShortPassword = 'a' * 4
  LongPassword = 'a' * 33
  BadName = "a&%T@%{ \003} elknart" # Should fail for space, printable specials, and control-C
  BadPassword = "a&%T@%{ \003} elknart" # Should fail for control-C
  GoodPassword = "zogity123*%^! 42"
  
  def failure_is_good( input_attributes )
    user = nil
    if input_attributes == {}
      user = User.new
    else
      user = User.new( input_attributes )
    end

    assert user.invalid?
  end
  
  setup do
    @input_attributes = {
        username: "uncle-mikey",
        realname: "Mi Key",
        password: GoodPassword,
        password_confirmation: GoodPassword,
    }
  end
  
  test "user attributes must not be empty" do
    empty = {}
    failure_is_good empty
  end
  
  test "create a new user" do
    assert User.new(@input_attributes).valid?
  end
    
  test "user's name should be unique" do
    user1 = User.create!(@input_attributes)
    failure_is_good @input_attributes
  end
  
  test "username should not be longer than 32 characters" do
    @input_attributes[:username] = LongName
    failure_is_good @input_attributes
  end
  
  test "realname should not be longer than 64 characters" do
    @input_attributes[:realname] = LongRealName
    failure_is_good @input_attributes
  end
  
  test "username should only contain alphanumerics and underscores" do
    @input_attributes[:username] = BadName
    failure_is_good @input_attributes
  end
  
  test "passwords have to match" do
    @input_attributes[:password_confirmation] = ShortPassword
    failure_is_good @input_attributes
  end
  
  test "passwords have to be at least 6 characters" do
    @input_attributes[:password] = ShortPassword
    @input_attributes[:password_confirmation] = ShortPassword
    failure_is_good @input_attributes
  end
  
  test "passwords shouldn't be more than 32 characters" do
    @input_attributes[:password] = LongPassword
    @input_attributes[:password_confirmation] = LongPassword
    failure_is_good @input_attributes
  end
  
  test "passwords should only contain alphanumerics underscores and some printable specials" do
    @input_attributes[:password] = BadPassword
    @input_attributes[:password_confirmation] = BadPassword
    failure_is_good @input_attributes
  end
  
  test "can authenticate user" do
    user = User.create!(@input_attributes)
    assert user.authenticate GoodPassword
  end
  
  test "wrong passwords don't authenticate" do
    user = User.create!(@input_attributes)
    assert false == user.authenticate( ShortPassword )
  end

  context "#has_role?" do
    setup do
      @user = User.create!(@input_attributes)
      @role = FactoryGirl.create(:role)
      @user.roles << @role
    end

    should "return true if appropriate" do
      assert @user.has_role? @role.name
      assert @user.has_role? @role.name, 'llama'
    end
    should "return false if appropriate" do
      assert false == @user.has_role?('god')
    end
  end

  context '#role_names' do
    setup do
      @user = User.create!(@input_attributes)
      @roles = [FactoryGirl.create(:role), FactoryGirl.create(:typical_role)]
      @user.roles << @roles
    end

    should 'return array of names' do
      assert_equal @user.role_names.sort, @roles.collect(&:name).sort
    end
  end

  context 'section role permissions' do
    setup do
      @section = FactoryGirl.create :section
      @role = FactoryGirl.create :role, name: 'section_regular_user'
      @user = User.create!(@input_attributes)
      @user.roles << @role

      SectionRole.create!(section: @section, role: @role, read: true, write: true)
    end

    should 'be able to read and write but not write secure' do
      assert @user.can_read_section? @section
      assert @user.can_write_section? @section
      assert_not @user.can_secure_section? @section
    end

    context 'someone cooler with secure permissions' do
      setup do
        SectionRole.create!(section: @section, role: @role, secure: true)
      end

      should 'be able to read_secure' do
        assert @user.can_secure_section? @section
      end
    end

    context 'someone with overlapping roles that add up' do
      setup do
        @role2 = FactoryGirl.create :role, name: 'superguy'
        @user.roles << @role2

        SectionRole.create(section: @section, role: @role2, secure: true)
      end

      should 'be able to read secure if any role can' do
        assert @user.can_secure_section? @section
      end
    end
  end
  
end
