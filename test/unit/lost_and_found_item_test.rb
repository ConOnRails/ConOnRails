require 'test_helper'

class LostAndFoundItemTest < ActiveSupport::TestCase
  fixtures :lost_and_found_items

  setup do
    @lost = lost_and_found_items(:lost)
    @found = lost_and_found_items(:found)
    @returned = lost_and_found_items(:returned)
  end

  test "cannot create lost item without cat, desc, last seen, flags false" do
    lfi = LostAndFoundItem.create
    assert lfi.invalid?
    assert lfi.errors[:category].any?
    assert lfi.errors[:description].any?
    assert lfi.errors[:where_last_seen].any?
    assert lfi.errors[:found].any?
    assert lfi.errors[:returned].any?
  end

  test "cannot create found item without cat, desc, where found, found true" do
    lfi = LostAndFoundItem.create
    assert lfi.invalid?
    assert lfi.errors[:category].any?
    assert lfi.errors[:description].any?
    assert lfi.errors[:where_found].any?
    assert lfi.errors[:found].any?
    assert lfi.errors[:returned].any?
  end

  test "lost item must have where_last_seen" do
    doom = @lost.attributes
    doom.delete "where_last_seen"
    lfi = LostAndFoundItem.create doom
    assert lfi.invalid?
    assert lfi.errors[:where_last_seen].any?
  end

  
end
