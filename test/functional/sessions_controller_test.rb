# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @role = FactoryBot.create :write_entries_role
    @user.roles << @role
    @user.save!
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should have the right title' do
    get :new
    assert_select 'title', 'Con On Rails | Mr X., Sign in please!'
  end

  test 'anon cannot create session' do
    get :create
    assert_not_nil flash[:notice]
    assert_redirected_to :root
  end

  test 'user can create session' do
    get :create, params: { username: @user.username, password: @user.password, role: @role.name }
    assert_equal 'Logged in!', flash[:notice]
    assert_not_nil session[:user_id]
    assert_equal @user.id, session[:user_id]
    assert_redirected_to :root
  end

  test 'can destroy session' do
    get :create, params: { username: @user.username, password: @user.password, role: @role.name }
    assert_not_nil session[:user_id]
    assert_equal @user.id, session[:user_id]
    get :destroy, session: { user_id: @user.id }
    assert_nil session[:user_id]
    assert_redirected_to :root
  end

  test 'can get roles for a given username' do
    get :getroles, xhr: true, format: :js, params: { username: @user.username }
    assert_not_nil assigns :rolenames
    assert_equal @role.name, assigns(:rolenames)[0]
  end

  context 'Index filters' do
    context 'POST :setup_index_filter' do
      setup do
        @filter = { hotel: true, llama: false }
        @safe_filter = ActionController::Parameters.new(hotel: 'true')
        post :set_index_filter, params: { index_filter: @filter }
      end

      should respond_with :redirect
      should redirect_to :root
      should 'have a sanitized filter' do
        assert_equal @safe_filter, session[:index_filter]
      end
    end

    context 'POST :clear_index_filter' do
      setup do
        session[:index_filter] = { hotel: true }
        post :clear_index_filter
      end

      should respond_with :redirect
      should redirect_to :root

      should 'have no filter' do
        assert_nil session[:index_filter]
      end
    end
  end
end
