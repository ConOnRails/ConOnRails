require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = FactoryGirl.build :valid_message
    @complete_message = FactoryGirl.create :valid_message_with_user
    @user = FactoryGirl.create :user

    @user_session = { user_id: @user.id }
  end

  test "should get index" do
    get :index, {}, @user_session
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new, {}, @user_session
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, { message: FactoryGirl.attributes_for(:valid_message_with_user) }, @user_session
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    get :show, { id: @complete_message.to_param }, @user_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @complete_message.to_param }, @user_session
    assert_response :success
  end

  test "should update message" do
    put :update, { id: @complete_message.to_param, message: FactoryGirl.attributes_for(:valid_message_with_user) }, @user_session
    assert_redirected_to messages_path
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, { id: @complete_message.to_param }, @user_session
    end

    assert_redirected_to messages_path
  end

  test "can close message" do
    assert @complete_message.is_active?
    put :update, { id: @complete_message.to_param, message: { is_active: false } }, @user_session
    assert assigns( :message ).is_active? == false
  end
end
