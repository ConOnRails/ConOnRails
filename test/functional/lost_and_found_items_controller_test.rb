require 'test_helper'

class LostAndFoundItemsControllerTest < ActionController::TestCase  
  setup do
    @missing = FactoryGirl.create :lost
    @found   = FactoryGirl.create :found
    @user = FactoryGirl.create :user
    @admin_role = FactoryGirl.create :can_admin_lost_and_found_user
    @user.roles << @admin_role
    @peon_user = FactoryGirl.create :peon
    @peon_role = FactoryGirl.create :role
    @peon_user.roles << @peon_role
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

  def get_show( user )
    get :show, { id: @missing.id }, { user_id: user.id }
    assert_response :success
    assert_template "show"
    assert_not_nil assigns :lfi
 end   

  test "peons can get show" do
    get_show @peon_user
  end

  test "non-peons can get show" do
    get_show @user
  end

  test "peons cannot get new" do
      get :new, { reported_missing: true }, { user_id: @peon_user.id }
      assert_redirected_to lost_and_found_url
    end

  test "non-peons should get new missing" do
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
  
  def can_search( user )
    get :search, { reported_missing: true, badge: 1 }, { user_id: user.id }
    assert_response :success
    assert_template "index"
    assert_not_nil assigns :lfis
  end
  
  test "peon can search by type 'badge" do
    can_search @peon_user
  end
  
  test "can search by type 'badge'" do
    can_search @user
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
    assert_equal 2, @controller.lfis.length
  end
  
  test "peon cannot create new lost" do
    assert_no_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: @missing.attributes }, { user_id: @peon_user.id }
    end
  end
  
  test "can create new lost" do
    assert_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: @missing.attributes }, { user_id: @user.id }
    end
  end
    
  test "peon cannot edit lost" do
    get :edit, { id: @missing.id }, { user_id: @peon_user.id }
    assert_redirected_to lost_and_found_url
  end    
  
  test "should get edit" do
    get :edit, { id: @missing.id }, { user_id: @user.id }
    assert_response :success
  end

#  test "should get update" do
#    get :update
#    assert_response :success
#  end

end
