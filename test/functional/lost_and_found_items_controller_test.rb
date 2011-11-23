require 'test_helper'

class LostAndFoundItemsControllerTest < ActionController::TestCase
  setup do
    @missing = lost_and_found_items :lost
    @found   = lost_and_found_items :found
    @user = users :one
  end
  
#  test "should get missing index" do
#    get :index, { reported_missing: true }, { user_id: @user.id }
#    assert_response :success
#  end

  test "should get show" do
    p @missing
    get :show, { id: @missing.id }, { user_id: @user.id }
    assert_response :success
    assert_template "show"
    assert_not_nil assigns :lfi
  end

  test "should get new missing" do
    get :new, { reported_missing: true }, { user_id: @user.id }
    assert_response :success
    assert_template "new"
  end

  test "should get new found" do
    get :new, { found: true }, { user_id: @user.id }
    assert_response :success
    assert_template "new"
  end
  
  test "should get missing search form" do
    get :searchform, { reported_missing: true }, { user_id: @user.id }
    assert_response :success
    assert_template "searchform"
  end
  
  test "can search" do
    get :search, { reported_missing: true, badge: 1 }, { user_id: @user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
  end
  
#  test "should get create" do
#    get :create
#    assert_response :success
#  end

#  test "should get edit" do
#    get :edit
#    assert_response :success
#  end

#  test "should get update" do
#    get :update
#    assert_response :success
#  end

end
