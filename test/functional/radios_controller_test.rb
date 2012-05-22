require 'test_helper'

class RadiosControllerTest < ActionController::TestCase
  setup do
    @radio = FactoryGirl.build :valid_blue_radio
    @user  = FactoryGirl.create :user
    @role  = FactoryGirl.create :admin_radios_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test "should get index" do
    get :index, { }, @user_session
    assert_response :success
    assert_not_nil assigns(:radios)
  end

  test "should get new" do
    get :new, { }, @user_session
    assert_response :success
  end

  test "should create radio" do
    assert_difference('Radio.count') do
      post :create, { radio: @radio.attributes }, @user_session
    end

    assert_redirected_to radio_path(assigns(:radio))
  end

  test "should show radio" do
    @radio.save!
    get :show, { id: @radio.to_param }, @user_session
    assert_response :success
  end

  test "should get edit" do
    @radio.save!
    get :edit, { id: @radio.to_param }, @user_session
    assert_response :success
  end

  test "should update radio" do
    @radio.save!
    put :update, { id: @radio.to_param, radio: @radio.attributes }, @user_session
    assert_redirected_to radio_path(assigns(:radio))
  end

  test "should destroy radio" do
    @radio.save!
    assert_difference('Radio.count', -1) do
      delete :destroy, { id: @radio.to_param }, @user_session
    end

    assert_redirected_to radios_path
  end
end
