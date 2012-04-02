require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @user = users :one
    @role = roles :admin
    @user.roles << @role
    
    @peon_user = users :two
    @peon_role = roles :peon
    @peon_user.roles << @peon_role
  end
  
  test "admin user should get index" do
    get :index, { }, { user_id: @user.id }
    assert_response :success
  end
  
  test "peon user should not get index" do
    get :index
    assert_redirected_to public_url
  end

end
