require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = FactoryGirl.create :event
    @other_event = FactoryGirl.create :ordinary_event
  end

  def make_one_inactive
    @event.is_active = false
    @event.save
    assert !@event.is_active?
  end
  
  def make_an_emergency
    @event.emergency = true
    @event.save
    assert @event.emergency
  end
  
  test "active flag should be true by default" do
    assert @event.is_active?
  end

  test "type flags should be false by default" do
    assert !@event.comment?
    assert !@event.flagged?
    assert !@event.post_con?
    assert !@event.quote?
    assert !@event.sticky?
    assert !@event.emergency?
    assert !@event.medical?
    assert !@event.hidden?
    assert !@event.secure?
  end

  test "department flags should be false by default" do
    assert !@event.consuite?
    assert !@event.hotel?
    assert !@event.parties?
    assert !@event.volunteers?
    assert !@event.dealers?
    assert !@event.dock?
    assert !@event.merchandise?
  end

  test "can revoke active status" do
    assert @event.is_active?
    @event.is_active = false
    assert !@event.is_active?
  end

  test "textual status is 'active' or 'closed'" do
    assert @event.is_active?
    assert_equal @event.status, 'Active'
    @event.is_active = false
    assert !@event.is_active?
    assert_equal @event.status, 'Closed'
  end

  test "list of available status makes sense" do
    statuses = Event.statuses
    assert_not_nil statuses
    assert_equal statuses, ['Active', 'Closed']
  end

  test "can set status by text" do
    assert @event.is_active?
    @event.status = 'Closed'
    assert !@event.is_active?, "Well, that didn't work"
  end

  test "setting bad status text raises exception" do
    assert @event.is_active?
    assert_raise Exception do
      @event.status = 'Fudgewidget'
    end
  end
  
  test "correct attributes are exposed" do
    event = Event.create!(@event.attributes)
  end
  
  test "can determine number of events" do
    Event.count
  end
  
  test "can determine number of active events" do
    assert_equal 2, Event.num_active
  end
  
  test "can determine number of inactive events" do
    make_one_inactive
    assert_equal 1, Event.num_inactive
  end
  
  test "can determine number of active emergencies" do
    make_an_emergency
    assert_equal 1, Event.num_active_emergencies
  end
end
