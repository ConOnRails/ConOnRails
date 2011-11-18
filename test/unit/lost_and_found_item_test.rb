require 'test_helper'

class LostAndFoundItemTest < ActiveSupport::TestCase
  fixtures :lost_and_found_items

  setup do
    @lost = lost_and_found_items(:lost)
    @found = lost_and_found_items(:found)
    @returned = lost_and_found_items(:returned)
  end

  test "default construction should be invalid" do
    lfi = LostAndFoundItem.create
    assert lfi.invalid?, "Vole"
    assert lfi.errors[:category].any?
    assert lfi.errors[:description].any?
    assert lfi.errors[:reported_missing].any?
    assert lfi.errors[:found].any?
  end
  
  test "cannot create an item that is both missing and found" do
    # Note: this is ONLY a workflow issue on create. Items can be UPDATED as
    # either missing or found if created with the other, and then both will
    # be true, but an item can only be CREATED as missing or found
    attrs = @lost.attributes
    attrs[:found] = true
    lfi = LostAndFoundItem.create(attrs)
    assert lfi.invalid?
    assert lfi.errors[:reported_missing].any?
    assert lfi.errors[:found].any?
  end
  
  test "item created missing MUST have where_last_seen owner_name owner_contact" do
    doom = @lost.attributes
    doom.delete "where_last_seen"
    doom.delete "owner_name"
    doom.delete "owner_contact"
    lfi = LostAndFoundItem.create doom
    assert lfi.invalid?
    assert lfi.errors[:where_last_seen].any?
    assert lfi.errors[:owner_name].any?
    assert lfi.errors[:owner_contact].any?
  end
  
  test "item created missing MUST NOT have where_found" do
    doom = @lost.attributes
    doom[:where_found] ="Doomland"
    lfi = LostAndFoundItem.create doom
    assert lfi.invalid?
    assert lfi.errors[:where_found].any?
  end
  
  test "item created found MUST have where_found" do
    doom = @found.attributes
    doom.delete "where_found"
    lfi = LostAndFoundItem.create doom
    assert lfi.invalid?
    assert lfi.errors[:where_found]
  end
  
  test "item created found MUST NOT have where_last_seen" do
    doom = @found.attributes
    doom[:where_last_seen] = "Doomland"
    lfi = LostAndFoundItem.create doom
    assert lfi.invalid?
    assert lfi.errors[:where_last_seen].any?
  end
  
  test "item updated missing MUST have where_last_seen other fields irrelevant" do
    doom = @found.attributes
    lfi = LostAndFoundItem.create!(doom)
    lfi.reported_missing = true
    lfi.save
    assert lfi.invalid?
    assert lfi.errors[:where_last_seen].any?
  end
  
  test "item updated found MUST have where_found other fields irrelevant" do
    doom = @lost.attributes
    lfi = LostAndFoundItem.create(doom)
    lfi.found = true
    lfi.save
    assert lfi.invalid?
    assert lfi.errors[:where_found].any?
  end

  test "category must be valid" do
    doom = @lost.attributes
    doom["category"] = "Llama" # This is only valid right now
    lfi = LostAndFoundItem.create(doom)
    assert lfi.invalid?
    assert lfi.errors[:category].any?
  end
end
