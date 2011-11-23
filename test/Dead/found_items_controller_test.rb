require 'test_helper'

class FoundItemsControllerTest < ActionController::TestCase
  
  setup do
    @found = lost_and_found_items :found
    @user = users :one
  end
  
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end

  test "should edit found item" do
    get :edit, { id: @found.to_param }, { user_id: @user.id }
    assert_response :success
  end
  
  test "should get new" do
    get :new, {}, { user_id: @user.id }
    assert_response :success
  end
  
  test "should show found item" do
    get :show, { id: @found.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "should create found item" do
    assert_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: @found.attributes }, { user_id: @user.id }
    end
    
    assert_redirected_to found_item_path(assigns(:lost_and_found_item))
  end

  test "should update found item" do
    put :update, { id: @found.to_param, lost_and_found_item: @found.attributes }, { user_id: @user.id }
    assert_redirected_to found_item_path(assigns(:lost_and_found_item))
  end

end
