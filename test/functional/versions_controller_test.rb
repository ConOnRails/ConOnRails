require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :read_audits_role
    @user.roles << @role

    @user_session = { user_id: @user.id, current_role_name: @role.name }
    @least_recent = mock
    @most_recent = mock
    @least_recent.stubs(:start_date).returns(3.days.ago)
    @most_recent.stubs(:start_date).returns(DateTime.now)
    @most_recent.stubs(:end_date).returns(3.days.from_now)
    Convention.stubs(:least_recent).returns(@least_recent)
    Convention.stubs(:most_recent).returns(@most_recent)
  end

  test "should get index" do
    get :index, {}, @user_session
    assert_response :success
  end
end