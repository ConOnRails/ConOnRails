require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.build :admin_users_role
    @user.roles << @role
    
    @peon_user = FactoryGirl.create :user
    @peon_role = FactoryGirl.build :role
    @peon_user.roles << @peon_role
  end
  
  test "admin user should get index" do
    get :index, { }, { user_id: @user.id }
    assert_response :success
  end
  
  test "peon user should not get index" do
    get :index
    assert_redirected_to :root
  end

end
