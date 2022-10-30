# frozen_string_literal: true

# == Schema Information
#
# Table name: lost_and_found_items
#
#  id              :integer          not null, primary key
#  category        :string
#  description     :string
#  details         :text
#  where_last_seen :string
#  where_found     :string
#  owner_name      :string
#  owner_contact   :text
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  rolename        :string
#  who_claimed     :string
#

require 'test_helper'

class LostAndFoundItemTest < ActiveSupport::TestCase
  setup do
    @lost = FactoryBot.build :lost
    @found = FactoryBot.build :found
    @both = FactoryBot.build :lost, found: true
    @returned = FactoryBot.build :returned
  end

  should belong_to :user
  should validate_presence_of :category
  should validate_presence_of :description

  should 'not be able to create with both missing and found' do
    assert_predicate @both, :invalid?
  end

  context 'lost' do
    subject { @lost }

    should validate_presence_of :where_last_seen
    should validate_presence_of :owner_name

    should 'be marked missing and not the others' do
      assert_predicate subject, :reported_missing?
      assert_not subject.found?
      assert_not subject.returned?
    end
  end

  context 'found' do
    subject { @found }

    should validate_presence_of :where_found

    should 'be marked found and not the others' do
      assert_predicate subject, :found?
      assert_not subject.reported_missing?
      assert_not subject.returned?
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
# end
