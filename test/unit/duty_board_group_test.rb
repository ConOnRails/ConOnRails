require 'test_helper'

class DutyBoardGroupsTest < ActiveSupport::TestCase
  def new_group
    yield DutyBoardGroup.new name:   Faker::Name.name,
                             row:    1,
                             column: 1
  end

  test "need a name, a row and a column" do
    DutyBoardGroup.new do |dbg|
      assert dbg.invalid?
      assert dbg.errors[:name].any?
      assert dbg.errors[:row].any?
      assert dbg.errors[:column].any?
    end
  end

  test "can create a valid group" do
    new_group do |dbg|
      assert dbg.valid?
    end
  end

  test "name must be unique" do
    new_group do |dbg|
      dbg.save!
      DutyBoardGroup.new dbg.attributes do |gbd|
        assert gbd.invalid?
      end
    end
  end

  test "row and column combo must be unique" do
    new_group do |dbg|
      dbg.save!
      DutyBoardGroup.new name: Faker::Name.name, row: 1, column: 1 do |gbd|
        assert gbd.invalid?
      end
    end
  end

  test "row and column combo must be in range" do
    DutyBoardGroup.new name: Faker::Name.name, row: 5, column: 3 do |dbg|
      assert dbg.invalid?
    end
  end
end
