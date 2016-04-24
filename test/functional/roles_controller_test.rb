require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  setup do
    @peon      = FactoryGirl.create :role
    @admin     = FactoryGirl.create :admin_users_role
    @user      = FactoryGirl.create :user
    @peon_user = FactoryGirl.create :user
    @user.roles << @admin
  end

  test "should get index" do
    get :index, { }, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test "peon can't get index" do
    get :index, { }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "anon can't get index" do
    get :index
    assert_redirected_to :public
  end

  test "should get new" do
    get :new, { }, { user_id: @user.id }
    assert_response :success
  end

  test "peon can't get new" do
    get :new, { }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "anon can't get new" do
    get :new
    assert_redirected_to :public
  end


  test "should create role" do
    assert_difference('Role.count') do
      post :create, { role: { name: "Foo" } }, { user_id: @user.id }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  test "peon can't create role" do
    assert_no_difference 'Role.count' do
      post :create, { role: { name: "Foo" } }, { user_id: @peon_user.id }
    end

    assert_redirected_to :public
  end

  test "anon can't create role" do
    assert_no_difference 'Role.count' do
      post :create, { role: { name: "Foo" } }
    end

    assert_redirected_to :public
  end

  test "cannot create role with bad data" do
    assert_no_difference 'Role.count' do
      post :create, { role: { name: "" } }, { user_id: @user.id }
    end

    assert assigns(:role).invalid?
    assert_template :new
  end

  test "should show role" do
    get :show, { id: @peon.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "peon can't show role" do
    get :show, { id: @peon.to_param }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "anon can't show role" do
    get :show, { id: @peon.to_param }
    assert_redirected_to :public
  end

  test "should get edit" do
    get :edit, { id: @peon.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "peon can't edit" do
    get :edit, { id: @peon.to_param }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "anon can't edit" do
    get :edit, { id: @peon.to_param }
    assert_redirected_to :public
  end

  test "should update role" do
    put :update, { id: @peon.to_param, role: { admin_users: true } }, { user_id: @user.id }
    assert_not_nil assigns(:role)
    assert assigns(:role).valid?
    assert assigns(:role).admin_users?
    assert_redirected_to role_path(assigns(:role))
  end

  test "can't update role with bad data" do
    put :update, { id: @peon.to_param, role: { name: "" } }, { user_id: @user.id }
    assert assigns(:role).invalid?
    assert_template :edit
  end

  test "peon can't update role" do
    put :update, { id: @peon.to_param, role: @peon.attributes }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "anon can't' update role" do
    put :update, { id: @peon.to_param, role: @peon.attributes }
    assert_redirected_to :public
  end

  test "should destroy role" do
    assert_difference('Role.count', -1) do
      delete :destroy, { id: @peon.to_param }, { user_id: @user.id }
    end

    assert_redirected_to roles_path
  end

  test "peon can't destroy role" do
    assert_no_difference 'Role.count' do
      delete :destroy, { id: @peon.to_param }, { user_id: @peon_user.id }
    end

    assert_redirected_to :public
  end

  test "anon can't destroy role" do
    assert_no_difference 'Role.count' do
      delete :destroy, { id: @peon.to_param }
    end

    assert_redirected_to :public
  end
end
