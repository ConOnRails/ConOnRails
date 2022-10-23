# frozen_string_literal: true

require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  setup do
    @user      = FactoryBot.create :user
    @peon_user = FactoryBot.create :user
    @role      = FactoryBot.create :admin_users_role
    @user.roles << @role
    @volunteer = FactoryBot.create :valid_volunteer
    @user_session = { user_id: @user.id }
    @peon_session = { user_id: @peon_user.id }
  end

  def get_index_success(session)
    get :index, session: session
    assert_response :success
    assert_not_nil assigns(:volunteers)
  end

  def get_index_fail(_session)
    get :index
    assert_redirected_to :public
    assert_nil assigns(:volunteers)
  end

  def get_new_success(session)
    get :new, session: session
    assert_not_nil assigns(:volunteer).volunteer_training
    assert_response :success
  end

  def get_new_fail(session)
    get :new, session: session
    assert_redirected_to :root
  end

  def post_create_success(session)
    assert_difference('Volunteer.count') do
      post :create, params: { volunteer: FactoryBot.attributes_for(:valid_volunteer) },
                    session: session
    end

    assert_redirected_to volunteer_path(assigns[:volunteer])
  end

  def post_create_auth_fail(session)
    assert_no_difference('Volunteer.count') do
      post :create, params: { volunteer: @volunteer.attributes }, session: session
    end

    assert_redirected_to :root
  end

  def get_show_success(session)
    get :show, params: { id: @volunteer.to_param }, session: session
    assert_response :success
  end

  def get_show_fail(session)
    get :show, params: { id: @volunteer.to_param }, session: session
    assert_redirected_to :root
  end

  def get_edit_success(session)
    get :edit, params: { id: @volunteer.to_param }, session: session
    assert_response :success
  end

  def get_edit_fail(session)
    get :edit, params: { id: @volunteer.to_param }, session: session
    assert_redirected_to :root
  end

  def put_update_success(session)
    put :update, params: { id: @volunteer.to_param,
                           volunteer: FactoryBot.attributes_for(:valid_volunteer) },
                 session: session
    assert_redirected_to volunteer_path(@volunteer)
  end

  def put_update_fail(session)
    put :update, params: { id: @volunteer.to_param,
                           volunteer: @volunteer.attributes }, session: session
    assert_redirected_to :root
  end

  test 'should get index' do
    get_index_success @user_session
  end

  test 'anon and peon cannot get index' do
    get_index_fail @peon_session
    get_index_fail nil
  end

  test 'should get new' do
    get_new_success @user_session
  end

  test 'anon and peon cannot get new' do
    get_new_fail @peon_session
    get_new_fail nil
  end

  test 'should create volunteer' do
    post_create_success @user_session
  end

  test 'anon and peon cannot create volunteer' do
    post_create_auth_fail @peon_session
    post_create_auth_fail nil
  end

  test 'should show volunteer' do
    get_show_success @user_session
  end

  test 'anon and peon cannot show' do
    get_show_fail @peon_session
    get_show_fail nil
  end

  test 'should get edit' do
    get_edit_success @user_session
  end

  test 'anon and peon cannot edit' do
    get_edit_fail @peon_session
    get_edit_fail nil
  end

  test 'should update volunteer' do
    put_update_success @user_session
  end

  test 'anon and peon cannot update' do
    put_update_fail @peon_session
    put_update_fail nil
  end

  context 'five volunteers with radio training' do
    setup do
      @volunteers = FactoryBot.create_list :valid_volunteer, 5
      @volunteers.each do |v|
        v.volunteer_training.radio = true
        v.volunteer_training.save
        v.reload
      end
    end

    context 'be able to clear all at once' do
      setup do
        get :clear_all_radio_training, session: @user_session
      end

      should redirect_to :volunteers
      should 'have no radio training' do
        Volunteer.find_each do |v|
          assert_not v.volunteer_training.radio
        end
      end
    end
  end
end
