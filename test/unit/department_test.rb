require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  setup do
    @department      = FactoryGirl.build :department
    @good_department = FactoryGirl.build :good_department
  end

  test "empty department is bad" do
    assert_no_difference 'Department.count' do
      dept = @department.save
    end
  end

  # This requirement is removed for now.
  #
  #test "department must have volunteer" do
  #  @good_department.volunteer = nil
  #  assert_no_difference 'Department.count' do
  #    dept = @good_department.save
  #  end
  #end

  test "department must have radio_group" do
    @good_department.radio_group = nil
    assert_no_difference 'Department.count' do
      dept = @good_department.save
    end
  end

  test "department name must be unique" do
    @good_department.save!
    assert_no_difference 'Department.count' do
      redundant_department = Department.new(@good_department.attributes)
      redundant_department.save
    end
  end
end
