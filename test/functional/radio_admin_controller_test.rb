require 'test_helper'

class RadioAdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @role = FactoryBot.create :admin_radios_role
    @user.roles << @role
  end
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end
end
