require 'test_helper'

class LostAndFoundItemsControllerTest < ActionController::TestCase
  setup do
    @missing    = FactoryGirl.create :lost
    @found      = FactoryGirl.create :found
    @returned   = FactoryGirl.create :returned
    @incomplete = FactoryGirl.build :incomplete
    @user       = FactoryGirl.create :user
    @admin_role = FactoryGirl.create :can_admin_lost_and_found_user
    @user.roles << @admin_role
    @peon_user = FactoryGirl.create :user
    @peon_role = FactoryGirl.create :role
    @peon_user.roles << @peon_role
    @change_this = { description: "Beware the viscous giraffe" }
  end

#  test "should get missing index" do
#    get :index, { reported_missing: true }, { user_id: @user.id }
#    assert_response :success
#  end
  test "must be authenticated" do
    get :show, { id: @missing.id }
    assert_redirected_to :public
    get :new, { reported_missing: true }
    assert_redirected_to :public
    get :searchform, { reported_missing: true }
    assert_redirected_to :public
  end

  def get_show(user)
    get :show, { id: @missing.id }, { user_id: user.id }
    assert_response :success
    assert_template :show
    assert_not_nil assigns :lfi
  end

  test "peons can get show" do
    get_show @peon_user
  end

  test "non-peons can get show" do
    get_show @user
  end

  test "peons cannot get new" do
    get :new, { lost_and_found_item: { reported_missing: true } }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "non-peons should get new missing" do
    get :new, { lost_and_found_item: { reported_missing: true } }, { user_id: @user.id }
    assert_response :success
    assert_template :new
  end

  test "should get new found" do
    get :new, { lost_and_found_item: { found: true } }, { user_id: @user.id }
    assert_response :success
    assert_template :new
  end

  test "should get missing search form" do
    get :searchform, { reported_missing: true }, { user_id: @user.id }
    assert_response :success
    assert_template :searchform
  end

  def can_search(user)
    get :index, { reported_missing: true, badge: 1 }, { user_id: user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
  end

  test "peon can search by type 'badge" do
    can_search @peon_user
  end

  test "can search by type 'badge'" do
    can_search @user
  end

  test "can search by single keyword" do
    get :index, { reported_missing: true, keywords: "Llamas" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 2, assigns(:lfis).length
  end

  test "can safely search with quotes or apostrophe in search term" do
    @missing.description = "Llama's"
    @missing.save!
    get :index, { reported_missing: true, keywords: "Llama's" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
  end

  test "can search by all of multiple keywords" do
    get :index, { reported_missing: true, search_type: "all", keywords: "Llamas Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 1, assigns(:lfis).length
  end

  test "can search by all of multiple keywords with an apostrophe" do
    get :index, { reported_missing: true, search_type: "all", keywords: "Llama's Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 0, assigns(:lfis).count
    # we don't actually have one of these. We just want to make sure apostrophe doesn't go boom.
  end


  test "can search for any of multiple keywords" do
    get :index, { reported_found: true, search_type: "any", keywords: "Llamas Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 2, assigns(:lfis).length
  end

  test "can search for any of multiple keywords with an apostrophe" do
    get :index, { reported_found: true, search_type: "any", keywords: "Llama's Tigers" }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    # TODO assert_equal 2, @controller.lfis.length
  end

  test "can force search to include returned" do
    get :index, { reported_missing: true, keywords: "Llamas", show_returned_only: true }, { user_id: @user.id }
    assert_response :success
    assert_equal 1, assigns(:lfis).length
  end

  test "peon cannot create new lost" do
    assert_no_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: @missing.attributes }, { user_id: @peon_user.id }
    end
  end

  test "can create new lost" do
    assert_difference 'LostAndFoundItem.count' do
      post :create, { lost_and_found_item: FactoryGirl.attributes_for(:lost) }, { user_id: @user.id }
    end
  end

  test "peon cannot edit lost" do
    get :edit, { id: @missing.id }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "should get edit" do
    get :edit, { id: @missing.id }, { user_id: @user.id }
    assert_response :success
  end

  test "can update" do
    put :update, { id: @missing.id, lost_and_found_item: @change_this }, { user_id: @user.id }
    assert_equal @change_this[:description], assigns(:lfi).description
    assert_redirected_to assigns(:lfi)
  end

  test "peon cannot update" do
    put :update, { id: @missing.id, lost_and_found_item: @change_this }, { user_id: @peon_user.id }
    assert_nil assigns(:lfi)
    assert_redirected_to :public
  end

  test "cannot update with incomplete information" do
    put :update, { id: @missing.id, lost_and_found_item: { description: "" } }, { user_id: @user.id }
    assert assigns(:lfi).invalid?
    assert_template :edit
  end

  test 'will limit by convention if conventions defined and in use' do
    @convention         = create :convention    # defaults to 5 days
    @missing.created_at = DateTime.now + 2.days # force this into range
    @found.created_at   = DateTime.now + 7.days # force this out of range
    @missing.save!
    @found.save!

    get :index, { convention: @convention.id }, { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_equal 1, assigns(:lfis).count
  end

end
