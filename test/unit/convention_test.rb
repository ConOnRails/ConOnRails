# == Schema Information
#
# Table name: conventions
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ConventionTest < ActiveSupport::TestCase
  context Convention do
    should validate_presence_of :name
    should validate_uniqueness_of :name
    should validate_presence_of :start_date
    should validate_presence_of :end_date

    context 'end_date earlier than start_date' do
      setup do
        @con = build :convention, end_date: DateTime.now - 5.days
      end

      should 'not be allowed' do
        assert @con.invalid?, 'Convention should be invalid'
        assert_not_nil @con.errors[:end_date], 'Errors for con.end_date should be set.'
      end
    end

    context '#current_convention' do
      setup do
        @old = FactoryGirl.create :convention, start_date: 365.days.ago, end_date: 362.days.ago
      end

      context 'nothing actually current defined' do
        should 'return the most recent' do
          assert_equal @old, Convention.current_convention
        end
      end

      context 'something recent defined' do
        setup do
          @current = FactoryGirl.create :convention, start_date: 1.day.ago, end_date: 2.days.from_now
        end

        should 'return the convention that maps to today' do
          assert_equal @current, Convention.current_convention
        end
      end

    end
  end
end
