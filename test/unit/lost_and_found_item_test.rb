# == Schema Information
#
# Table name: lost_and_found_items
#
#  id              :integer          not null, primary key
#  category        :string(255)
#  description     :string(255)
#  details         :text
#  where_last_seen :string(255)
#  where_found     :string(255)
#  owner_name      :string(255)
#  owner_contact   :text
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  rolename        :string(255)
#  who_claimed     :string(255)
#

require 'test_helper'

class LostAndFoundItemTest < ActiveSupport::TestCase

  setup do
    @lost = FactoryGirl.build :lost
    @found = FactoryGirl.build :found
    @both = FactoryGirl.build :lost, found: true
    @returned = FactoryGirl.build :returned
  end

  should validate_presence_of :category
  #should validate_inclusion_of(:category).in_array LostAndFoundItem.valid_categories.keys
  should validate_presence_of :description

  should "not be able to create with both missing and found" do
    assert @both.invalid?
  end

  context "lost" do
    subject { @lost }

    should validate_presence_of :where_last_seen
    should validate_presence_of :owner_name

    should "be marked missing and not the others" do
      assert subject.reported_missing?
      assert !subject.found?
      assert !subject.returned?
    end
  end

  context "found" do
    subject { @found }

    should validate_presence_of :where_found

    should "be marked found and not the others" do
      assert subject.found?
      assert !subject.reported_missing?
      assert !subject.returned?
    end
  end

end

#  test "missing items report 'missing' type" do
#    assert_equal @lost.type, 'missing'
#  end
#
#  test "found items report 'found' type" do
#    assert_equal @found.type, 'found'
#  end
#
#  test "returned items report 'returned' type" do
#    assert_equal @returned.type, 'returned'
#  end
#end
