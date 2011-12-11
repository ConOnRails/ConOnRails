require 'test_helper'

class LostAndFoundItemsControllerTest < ActionController::TestCase
  fixtures :lost_and_found_items
  
  setup do
    @missing = lost_and_found_items :lost
    @found   = lost_and_found_items :found
    @user = users :one
  end
  
#  test "should get missing index" do
#    get :index, { reported_missing: true }, { user_id: @user.id }
#    assert_response :success
#  end
  test "must be authenticated" do
    get :show, { id: @missing.id }
    assert_response :redirect
    get :new, { reported_missing: true }
    assert_response :redirect
    get :searchform, { reported_missing: true }
    assert_response :redirect
  end

  test "should get show" do
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
  
  test "can search by type 'badge'" do
    get :search, { reported_missing: true, badge: 1 }, { user_id: @user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
  end
  
  test "can search by single keyword" do
    get :search, { reported_missing: true, keywords: "Llamas"}, { user_id: @user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
    assert_equal 2, @controller.lfis.length
  end
  
  test "can search by all of multiple keywords" do
    get :search, { reported_missing: true, search_type: "all", keywords: "Llamas Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
    assert_equal 1, @controller.lfis.length
  end
  
  test "can search for any of multiple keywords" do
    get :search, { reported_found: true, search_type: "any", keywords: "Llamas Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
    p @controller.lfis
    assert_equal 2, @controller.lfis.length
  end
  
  test "can mark an missing item found" do
    get :show, { id: @missing.id }, { user_id: @user.id }
    assert_response :success
    assert_template "show"
    post :mark_found, { id: @missing.id }, { user_id: @user.id }
    assert_response :success
    assert_template "show"
    assert_equal true, @controller.lfi.found?
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
