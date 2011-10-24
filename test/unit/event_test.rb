require 'test_helper'

class EventTest < ActiveSupport::TestCase
  fixtures :events

  test "active flag should be true by default" do
    event = Event.new
    assert event.is_active?
  end

  test "type flags should be false by default" do
    event = Event.new
    assert !event.comment?
    assert !event.flagged?
    assert !event.post_con?
    assert !event.quote?
    assert !event.sticky?
    assert !event.emergency?
    assert !event.medical?
    assert !event.hidden?
    assert !event.secure?
  end

  test "department flags should be false by default" do
    event = Event.new
    assert !event.consuite?
    assert !event.hotel?
    assert !event.parties?
    assert !event.volunteers?
    assert !event.dealers?
    assert !event.dock?
    assert !event.merchandise?
  end

  test "can revoke active status" do
    event = Event.new
    assert event.is_active?
    event.is_active = false
    assert !event.is_active?
  end

  test "textual status is 'active' or 'closed'" do
    event = Event.new
    assert event.is_active?
    assert_equal event.status, 'Active'
    event.is_active = false
    assert !event.is_active?
    assert_equal event.status, 'Closed'
  end

  test "list of available status makes sense" do
    statuses = Event.statuses
    assert_not_nil statuses
    assert_equal statuses, ['Active', 'Closed']
  end

  test "can set status by text" do
    event = Event.new
    assert event.is_active?
    event.status = 'Closed'
    assert !event.is_active?, "Well, that didn't work"
  end

  test "setting bad status text raises exception" do
    event = Event.new
    assert event.is_active?
    assert_raise Exception do
      event.status = 'Fudgewidget'
    end
  end
  
  test "correct attributes are exposed" do
    event = Event.create!(@event.to_param)
  end
end
