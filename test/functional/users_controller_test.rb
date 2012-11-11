require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  GoodPassword = "zogity123*%^! 42"

  setup do
    @user = FactoryGirl.create :user
    p @user.valid?
    @role = FactoryGirl.create :admin_users_role
    @user.roles << @role

    @peon_user = FactoryGirl.create :peon
    @peon_role = FactoryGirl.create :role
    @peon_user.roles << @peon_role

    @volunteer = FactoryGirl.create :valid_volunteer

    @input_attributes = {
        name:                  "mikey",
        realname:              "Mi Key",
        password:              GoodPassword,
        password_confirmation: GoodPassword,
    }
  end

  test "no index for peons" do
    get :index, { }, { user_id: @peon_user.id }
    assert_redirected_to public_url
  end

  test "should get index" do
    get :index, { }, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "peons cannot get new" do
    get :new, { }, { user_id: @peon_user.id }
    assert_redirected_to public_url
  end

  test "should get new" do
    get :new, { }, { user_id: @user.id }
    assert_response :success
  end

  test "peons cannot create user" do
    assert_no_difference 'User.count' do
      post :create, { user: @input_attributes }, { user_id: @peon_user.id }
    end

    assert_redirected_to public_url
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, { user: @input_attributes }, { user_id: @user.id }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should create user with associated volunteer" do
    assert_difference('User.count') do
      post :create, { user: @input_attributes, volunteer: @volunteer.id }, { user_id: @user.id }
    end

    assert_equal @volunteer.id, assigns(:user).volunteer.id
    assert_redirected_to user_path(assigns :user)

  end

  test "cannot create user with incomplete data" do
    assert_no_difference('User.count') do
      post :create, { user: { name: "" } }, { user_id: @user.id }
    end

    assert_template :new
  end

  test "peons cannot show user" do
    get :show, { id: @user.to_param }, { user_id: @peon_user.id }
    assert_redirected_to public_url
  end

  test "should show user" do
    get :show, { id: @user.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "peons cannot edit" do
    get :edit, { id: @user.to_param }, { user_id: @peon_user.id }
    assert_redirected_to public_url
  end

  test "should get edit" do
    get :edit, { id: @user.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "peons cannot update users" do
    put :update, { id: @user.to_param, user: @input_attributes }, { user_id: @peon_user.id }
    assert_nil assigns(:user)
    assert_redirected_to public_url
  end

  test "should update user" do
    put :update, { id: @user.to_param, user: { realname: "wombat" } }, { user_id: @user.id }
    assert assigns(:user).valid?
    assert_equal "wombat", assigns(:user).realname
    assert_redirected_to user_path(assigns(:user))
  end

  test "should update user with associated volunteer" do
    put :update, { id: @user.to_param, user: { realname: "wombat" }, volunteer: @volunteer.id }, { user_id: @user.id }
    assert assigns(:user).valid?
    assert_equal "wombat", assigns(:user).realname
    assert_equal @volunteer.id, assigns(:user).volunteer.id
    assert_redirected_to user_path(assigns(:user))
  end

  test "cannot update user with invalid info" do
    put :update, { id: @user.to_param, user: { name: "" } }, { user_id: @user.id }
    assert assigns(:user).invalid?
    assert_template :edit
  end

  test "peons cannot destroy user" do
    assert_no_difference 'User.count' do
      delete :destroy, { id: @user.to_param }, { user_id: @peon_user.id }
    end

    assert_redirected_to public_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, { id: @user.to_param }, { user_id: @user.id }
    end

    assert_redirected_to users_path
  end
end
