require 'test_helper'

class RadioAdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :admin_radios_role
    @user.roles << @role

  end
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end

end
