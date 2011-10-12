require 'test_helper'

class EntryTest < ActiveSupport::TestCase
    fixtures :entries

    test "entry attributes must not be empty" do
        entry = Entry.new
        assert entry.invalid?
        assert entry.errors[:description].any?
        assert entry.errors[:user].any?
        assert entry.errors[:event].any?
    end
end
