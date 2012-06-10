require 'test_helper'

class DutyBoardSlotTest < ActiveSupport::TestCase
  def new_slot
    yield DutyBoardSlot.new name:       Faker::Name.name,
                            department: FactoryGirl.create(:good_department)
  end

  test "dbs needs a name and a department" do
    DutyBoardSlot.new do |dbs|
      assert dbs.invalid?, "DBS should be invalid"
      assert dbs.errors[:name].any?
      assert dbs.errors[:department].any?
    end
  end

  test "dbs with everything should work" do
    new_slot do |dbs|
      assert dbs.valid?
    end
  end
end
