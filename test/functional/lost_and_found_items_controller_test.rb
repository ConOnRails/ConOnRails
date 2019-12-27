# frozen_string_literal: true

require 'test_helper'

class LostAndFoundItemsControllerTest < ActionController::TestCase
  setup do
    @missing    = FactoryBot.create :lost
    @found      = FactoryBot.create :found
    @returned   = FactoryBot.create :returned
    @retired_category = FactoryBot.create :retired_category
    @incomplete = FactoryBot.build :incomplete
    @user       = FactoryBot.create :user
    @admin_role = FactoryBot.create :can_admin_lost_and_found_user
    @user.roles << @admin_role
    @peon_user = FactoryBot.create :user
    @peon_role = FactoryBot.create :role
    @peon_user.roles << @peon_role
    @change_this = { description: 'Beware the viscous giraffe' }
  end

  #  test "should get missing index" do
  #    get :index, { reported_missing: true }, { user_id: @user.id }
  #    assert_response :success
  #  end
  test 'must be authenticated' do
    get :show, params: { id: @missing.id }
    assert_redirected_to :public
    get :new, params: { reported_missing: true }
    assert_redirected_to :public
    get :searchform, params: { reported_missing: true }
    assert_redirected_to :public
  end

  def get_show(user)
    get :show, params: { id: @missing.id }, session: { user_id: user.id }
    assert_response :success
    assert_template :show
    assert_not_nil assigns :lfi
  end

  test 'peons can get show' do
    get_show @peon_user
  end

  test 'non-peons can get show' do
    get_show @user
  end

  test 'peons cannot get new' do
    get :new, params: { lost_and_found_item: { reported_missing: true } }, session: { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test 'non-peons should get new missing' do
    get :new, params: { lost_and_found_item: { reported_missing: true } }, session: { user_id: @user.id }
    assert_response :success
    assert_template :new
  end

  test 'should get new found' do
    get :new, params: { lost_and_found_item: { found: true } }, session: { user_id: @user.id }
    assert_response :success
    assert_template :new
  end

  test 'should get missing search form' do
    get :searchform, params: { reported_missing: true }, session: { user_id: @user.id }
    assert_response :success
    assert_template :searchform
  end

  def can_search(user)
    get :index, params: { reported_missing: true, badge: 1 }, session: { user_id: user.id }
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

  test 'can search description by single keyword' do
    get :index, params: { reported_missing: true,
                          keywords: 'Llamas' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 2, assigns(:lfis).length
  end

  test 'can search details by single keyword' do
    get :index, params: { reported_missing: true, keywords: 'Oh' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 1, assigns(:lfis).length
  end

  test 'can safely search description with quotes or apostrophe in search term' do
    @missing.description = "Llama's"
    @missing.save!
    get :index, params: { reported_missing: true,
                          keywords: "Llama's" }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
  end

  test 'can safely search details with quotes or apostrophe in search term' do
    @missing.details = "Customer's"
    @missing.save!
    get :index, params: { reported_missing: true,
                          keywords: "Customer's" }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
  end

  test 'can search description by all of multiple keywords' do
    get :index, params: { reported_missing: true, search_type: 'all',
                          keywords: 'Llamas Tigers' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 1, assigns(:lfis).length
  end

  test 'can search detais by all of multiple keywords' do
    get :index, params: { reported_missing: true, search_type: 'all',
                          keywords: 'Oh My!' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 1, assigns(:lfis).length
  end

  test 'can search by all of multiple keywords with an apostrophe' do
    get :index, params: { reported_missing: true, search_type: 'all',
                          keywords: "Llama's Tigers" }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 0, assigns(:lfis).count
    # we don't actually have one of these. We just want to make sure apostrophe doesn't go boom.
  end

  test 'can search description for any of multiple keywords' do
    get :index, params: { reported_found: true, search_type: 'any',
                          keywords: 'Llamas Tigers' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 2, assigns(:lfis).length
  end

  test 'can search details for any of multiple keywords' do
    get :index, params: { reported_found: true, search_type: 'any',
                          keywords: 'Oh My!' }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    assert_equal 1, assigns(:lfis).length
  end

  test 'can search for any of multiple keywords with an apostrophe' do
    get :index, params: { reported_found: true, search_type: 'any',
                          keywords: "Llama's Tigers" }, session: { user_id: @user.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns :lfis
    # TODO: assert_equal 2, @controller.lfis.length
  end

  test 'can force search to include returned' do
    get :index, params: { reported_missing: true, keywords: 'Llamas',
                          show_returned_only: true }, session: { user_id: @user.id }
    assert_response :success
    assert_equal 1, assigns(:lfis).length
  end

  test 'peon cannot create new lost' do
    assert_no_difference 'LostAndFoundItem.count' do
      post :create, params: { lost_and_found_item: @missing.attributes }, session: { user_id: @peon_user.id }
    end
  end

  test 'can create new lost' do
    assert_difference 'LostAndFoundItem.count' do
      post :create, params: { lost_and_found_item: FactoryBot.attributes_for(:lost) }, session: { user_id: @user.id }
    end
  end

  test 'peon cannot edit lost' do
    get :edit, params: { id: @missing.id }, session: { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test 'should get edit' do
    get :edit, params: { id: @missing.id }, session: { user_id: @user.id }
    assert_response :success
  end

  test 'can update' do
    put :update, params: { id: @missing.id,
                           lost_and_found_item: @change_this }, session: { user_id: @user.id }
    assert_equal @change_this[:description], assigns(:lfi).description
    assert_redirected_to assigns(:lfi)
  end

  test 'can updated item with retired category' do
    put :update, params: { id: @retired_category.id,
                           lost_and_found_item: @change_this }, session: { user_id: @user.id }
    assert_equal @change_this[:description], assigns(:lfi).description
    assert_redirected_to assigns(:lfi)
  end

  test 'peon cannot update' do
    put :update, params: { id: @missing.id,
                           lost_and_found_item: @change_this }, session: { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test 'cannot update with incomplete information' do
    put :update, params: { id: @missing.id,
                           lost_and_found_item: { description: '' } }, session: { user_id: @user.id }
    assert assigns(:lfi).invalid?
    assert_template :edit
  end

  test 'will limit by convention if conventions defined and in use' do
    Timecop.freeze do
      @convention         = create :convention    # defaults to 5 days
      @missing.created_at = DateTime.now + 2.days # force this into range
      @found.created_at   = DateTime.now + 7.days # force this out of range
      @missing.save!
      @found.save!

      get :index, params: { convention: @convention.id }, session: { user_id: @user.id }
    end
    assert_response :success
    assert_template :index
    assert_equal 1, assigns(:lfis).count
  end
end
