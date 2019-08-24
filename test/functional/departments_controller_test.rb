# frozen_string_literal: true

require 'test_helper'

class DepartmentsControllerTest < ActionController::TestCase
  setup do
    @department = FactoryBot.build :department
    @valid_department = FactoryBot.build :good_department
    @group = FactoryBot.create :blue_man_group
    @user = FactoryBot.create :user
    @role = FactoryBot.create :admin_radios_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test 'should get index' do
    get :index, session: @user_session
    assert_response :success
    assert_not_nil assigns(:departments)
  end

  test 'should get new' do
    get :new, session: @user_session
    assert_response :success
  end

  test 'should create department' do
    assert_difference('Department.count') do
      post :create, params: { department: FactoryBot.attributes_for(:good_department,
                                                                    radio_group_id: @group.id) }, session: @user_session
    end

    assert_redirected_to department_path(assigns(:department))
  end

  test 'should show department' do
    @valid_department.save!
    get :show, params: { id: @valid_department.to_param }, session: @user_session
    assert_response :success
  end

  test 'should get edit' do
    @valid_department.save!
    get :edit, params: { id: @valid_department.to_param }, session: @user_session
    assert_response :success
  end

  test 'should update department' do
    @valid_department.save!
    put :update, params: { id: @valid_department.to_param,
                           department: FactoryBot.attributes_for(:good_department) }, session: @user_session
    assert_redirected_to department_path(assigns(:department))
  end

  test 'should destroy department' do
    @valid_department.save!
    assert_difference('Department.count', -1) do
      delete :destroy, params: { id: @valid_department.to_param }, session: @user_session
    end

    assert_redirected_to departments_path
  end
end
