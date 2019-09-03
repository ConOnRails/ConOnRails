# frozen_string_literal: true

require 'test_helper'

class RadioGroupsControllerTest < ActionController::TestCase
  setup do
    @radio_group = FactoryBot.create :blue_man_group
    @invalid_group = FactoryBot.build :radio_group

    @user = FactoryBot.create :user
    @role = FactoryBot.create :admin_radios_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test 'should get index' do
    get :index, session: @user_session
    assert_response :success
    assert_not_nil assigns(:radio_groups)
  end

  test 'should get new' do
    get :new, session: @user_session
    assert_response :success
  end

  test 'should create radio_group' do
    assert_difference('RadioGroup.count') do
      post :create, params: { radio_group: FactoryBot.attributes_for(:red_handed) }, session: @user_session
    end

    assert_redirected_to radio_group_path(assigns(:radio_group))
  end

  test 'should show radio_group' do
    get :show, params: { id: @radio_group.to_param }, session: @user_session
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @radio_group.to_param }, session: @user_session
    assert_response :success
  end

  test 'should update radio_group' do
    put :update, params: { id: @radio_group.to_param,
                           radio_group: FactoryBot.attributes_for(:red_handed) }, session: @user_session
    assert_redirected_to radio_group_path(assigns(:radio_group))
  end

  test 'should destroy radio_group' do
    assert_difference('RadioGroup.count', -1) do
      delete :destroy, params: { id: @radio_group.to_param }, session: @user_session
    end

    assert_redirected_to radio_groups_path
  end
end
