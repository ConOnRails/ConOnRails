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
  end
end
