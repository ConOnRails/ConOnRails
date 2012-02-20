require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  setup do
    @peon = roles(:peon)
    @admin = roles(:admin)
    @user = users :one
  end

  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test "should get new" do
    get :new, {}, { user_id: @user.id }
    assert_response :success
  end

  test "should create role" do
    assert_difference('Role.count') do
      post :create,  { role: @peon.attributes }, { user_id: @user.id }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  test "should show role" do
    get :show, { id: @peon.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @peon.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "should update role" do
    put :update, { id: @peon.to_param }, { role: @peon.attributes, user_id: @user.id }
    assert_redirected_to role_path(assigns(:role))
  end

  test "should destroy role" do
    assert_difference('Role.count', -1) do
      delete :destroy, { id: @peon.to_param }, { user_id: @user.id }
    end

    assert_redirected_to roles_path
  end
end
