require 'test_helper'

class EventTest < ActiveSupport::TestCase

  should have_many :entries
  should have_many :event_flag_histories

  context "an ordinary event" do
    setup do
      @event = FactoryGirl.create :ordinary_event
    end

    should "be active by default" do
      assert @event.is_active?
    end

    should "have false type flags by default" do
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

    should "have false department flags by default" do
      assert !@event.consuite?
      assert !@event.hotel?
      assert !@event.parties?
      assert !@event.volunteers?
      assert !@event.dealers?
      assert !@event.dock?
      assert !@event.merchandise?
    end

    should "have correct textual status" do
      assert_equal 'Active', @event.status
      @event.is_active = false
      assert_equal 'Closed', @event.status
    end

    should "set textual status and get right flags" do
      @event.status = 'Closed'
      assert !@event.is_active?
      @event.status = 'Active'
      assert @event.is_active?
    end

    should "raise exception on invalid status text" do
      assert_raise Exception do
        @event.status = 'Fudgewidget'
      end
    end

    should "detect flag changes" do
      params = { hidden: true, secure: false }
      assert @event.flags_differ? params
      params = { hidden: false }
      assert_equal false, @event.flags_differ?(params)
    end

    context "an additional ordinary event" do
      setup do
        @second_event = FactoryGirl.create :event
      end

      should "have two active events" do
        assert_equal 2, Event.num_active
      end

      context "one event made inactive" do
        setup do
          @second_event.is_active = false
          @second_event.save!
        end

        should "have one inactive" do
          assert_equal 1, Event.num_inactive
        end
      end

      context "one event is an emergency" do
        setup do
          @second_event.emergency = true
          @second_event.save!
        end

        should "have one active emergency" do
          assert_equal 1, Event.num_active_emergencies
        end

        context "emergency is closed" do
          setup do
            @second_event.status = 'Closed'
            @second_event.save!
          end

          should "have no active emergencies" do
            assert_equal 0, Event.num_active_emergencies
          end
        end
      end

      context "one event is an medical" do
        setup do
          @second_event.medical = true
          @second_event.save!
        end

        should "have one active medical" do
          assert_equal 1, Event.num_active_medicals
        end

        context "medical is closed" do
          setup do
            @second_event.status = 'Closed'
            @second_event.save!
          end

          should "have no active medicals" do
            assert_equal 0, Event.num_active_medicals
          end
        end
      end

      context "stuff we want to filter" do
        setup do
          @user = FactoryGirl.create :user

          @role = FactoryGirl.create :write_entries_role
          @user.roles << @role

          @filter = Event.build_permissions @user
        end

        should "have a correctly constructed filter" do

          assert_equal 2, @filter.size
          assert_equal false, @filter[:hidden]
          assert_equal false, @filter[:secure]

          @user.roles << FactoryGirl.create(:rw_secure_role)
          @filter = Event.build_permissions @user
          assert_equal 1, @filter.size
          assert_nil @filter[:secure]
          assert_equal false, @filter[:hidden]

          @user.roles << FactoryGirl.create(:read_hidden_entries_role)
          @filter = Event.build_permissions @user
          assert_equal 0, @filter.size
        end

        context "filtering active true" do
          setup do
            @params = { active: true  }
            @zog = Event.build_filter(@user, @params)
          end

          should "have stuff" do
             assert_equal 2, @zog.count
          end
        end
        context "filtering secure true" do
          setup do
            @params = { secure: true }
            @zog = Event.build_filter(@user, @params)
          end

          should "have stuff" do
            assert_equal 0, @zog.count # Except we don't really ahve stuff yet
          end

        end
      end

    end
  end
end
