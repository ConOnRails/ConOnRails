# frozen_string_literal: true

require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  setup do
    @peon      = FactoryBot.create :role
    @admin     = FactoryBot.create :admin_users_role
    @user      = FactoryBot.create :user
    @peon_user = FactoryBot.create :user
    @user.roles << @admin
  end

  test 'should get index' do
    get :index, session: { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test "peon can't get index" do
    get :index, session: { user_id: @peon_user.id }
    assert_redirected_to :root
  end

  test "anon can't get index" do
    get :index
    assert_redirected_to :public
  end

  test 'should get new' do
    get :new, session: { user_id: @user.id }
    assert_response :success
  end

  test "peon can't get new" do
    get :new, session: { user_id: @peon_user.id }
    assert_redirected_to :root
  end

  test "anon can't get new" do
    get :new
    assert_redirected_to :public
  end

  test 'should create role' do
    assert_difference('Role.count') do
      post :create, params: { role: { name: 'Foo' } }, session: { user_id: @user.id }
    end

    assert_redirected_to role_path(assigns(:role))
  end

  test "peon can't create role" do
    assert_no_difference 'Role.count' do
      post :create, params: { role: { name: 'Foo' } }, session: { user_id: @peon_user.id }
    end

    assert_redirected_to :root
  end

  test "anon can't create role" do
    assert_no_difference 'Role.count' do
      post :create, params: { role: { name: 'Foo' } }
    end

    assert_redirected_to :public
  end

  test 'cannot create role with bad data' do
    assert_no_difference 'Role.count' do
      post :create, params: { role: { name: '' } }, session: { user_id: @user.id }
    end

    assert assigns(:role).invalid?
    assert_template :new
  end

  test 'should show role' do
    get :show, params: { id: @peon.to_param }, session: { user_id: @user.id }
    assert_response :success
  end

  test "peon can't show role" do
    get :show, params: { id: @peon.to_param }, session: { user_id: @peon_user.id }
    assert_redirected_to :root
  end

  test "anon can't show role" do
    get :show, params: { id: @peon.to_param }
    assert_redirected_to :public
  end

  test 'should get edit' do
    get :edit, params: { id: @peon.to_param }, session: { user_id: @user.id }
    assert_response :success
  end

  test "peon can't edit" do
    get :edit, params: { id: @peon.to_param }, session: { user_id: @peon_user.id }
    assert_redirected_to :root
  end

  test "anon can't edit" do
    get :edit, params: { id: @peon.to_param }
    assert_redirected_to :public
  end

  test 'should update role' do
    put :update, params: { id: @peon.to_param,
                           role: { write_entries: true } }, session: { user_id: @user.id }
    assert_not_nil assigns(:role)
    assert assigns(:role).valid?
    assert assigns(:role).write_entries?
    assert_redirected_to role_path(assigns(:role))
  end

  test "can't update role with bad data" do
    put :update, params: { id: @peon.to_param, role: { name: '' } }, session: { user_id: @user.id }
    assert assigns(:role).invalid?
    assert_template :edit
  end

  test "peon can't update role" do
    put :update, params: { id: @peon.to_param,
                           role: @peon.attributes }, session: { user_id: @peon_user.id }
    assert_redirected_to :root
  end

  test "anon can't' update role" do
    put :update, params: { id: @peon.to_param, role: @peon.attributes }
    assert_redirected_to :public
  end

  test 'should destroy role' do
    assert_difference('Role.count', -1) do
      delete :destroy, params: { id: @peon.to_param }, session: { user_id: @user.id }
    end

    assert_redirected_to roles_path
  end

  test "peon can't destroy role" do
    assert_no_difference 'Role.count' do
      delete :destroy, params: { id: @peon.to_param }, session: { user_id: @peon_user.id }
    end

    assert_redirected_to :root
  end

  test "anon can't destroy role" do
    assert_no_difference 'Role.count' do
      delete :destroy, params: { id: @peon.to_param }
    end

    assert_redirected_to :public
  end
end
