require 'test_helper'

class DepartmentsControllerTest < ActionController::TestCase
  setup do
    @department = FactoryGirl.build :department
    @valid_department = FactoryGirl.build :good_department
    @group = FactoryGirl.create :blue_man_group
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :admin_radios_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test "should get index" do
    get :index, {}, @user_session
    assert_response :success
    assert_not_nil assigns(:departments)
  end

  test "should get new" do
    get :new, {}, @user_session
    assert_response :success
  end

  test "should create department" do
    assert_difference('Department.count') do
      post :create, { department: FactoryGirl.attributes_for(:good_department, radio_group_id: @group.id) }, @user_session
    end

    assert_redirected_to department_path(assigns(:department))
  end

  test "should show department" do
    @valid_department.save!
    get :show, { id: @valid_department.to_param }, @user_session
    assert_response :success
  end

  test "should get edit" do
    @valid_department.save!
    get :edit, { id: @valid_department.to_param }, @user_session
    assert_response :success
  end

  test "should update department" do
    @valid_department.save!
    put :update, { id: @valid_department.to_param, department: FactoryGirl.attributes_for(:good_department) }, @user_session
    assert_redirected_to department_path(assigns(:department))
  end

  test "should destroy department" do
    @valid_department.save!
    assert_difference('Department.count', -1) do
      delete :destroy, { id: @valid_department.to_param }, @user_session
    end

    assert_redirected_to departments_path
  end
end
