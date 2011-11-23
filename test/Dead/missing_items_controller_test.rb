require 'test_helper'

class MissingItemsControllerTest < ActionController::TestCase
  setup do
    @missing = lost_and_found_items :lost
    @user = users :one
  end
  
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end

  test "should get new" do
    get :new, {}, { user_id: @user.id }
    assert_response :success
  end

  test "should edit missing item" do
    get :edit, { id: @missing.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "should show missing item" do
    get :show, { id: @missing.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "should create missing item" do
    assert_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: @missing.attributes }, { user_id: @user.id }
    end
    
    assert_redirected_to missing_item_path(assigns(:lost_and_found_item))
  end

  test "should update missing item" do
    put :update, { id: @missing.to_param, lost_and_found_item: @missing.attributes }, { user_id: @user.id }
    assert_redirected_to missing_item_path(assigns(:lost_and_found_item))
  end

end
