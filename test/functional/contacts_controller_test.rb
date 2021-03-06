# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @user      = FactoryBot.create :user
    @contact   = FactoryBot.create :valid_contact
    @peon_user = FactoryBot.create :user
    @role      = FactoryBot.create :write_entries_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
    @peon_user_session = { user_id: @peon_user.id }
  end

  def get_index_success(session)
    get :index, session: session
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  def get_index_fail(session)
    get :index, session: session
    assert_redirected_to session.nil? ? :public : :root
  end

  def get_new_success(session)
    get :new, session: session
    assert_response :success
  end

  def get_new_fail(session)
    get :new, session: session
    assert_redirected_to :root
  end

  def create_contact_success(session)
    assert_difference('Contact.count') do
      post :create, params: { contact: FactoryBot.attributes_for(:valid_contact) }, session: session
    end

    assert_redirected_to contacts_path
  end

  def create_contact_auth_fail(session)
    assert_no_difference 'Contact.count' do
      post :create, params: { contact: @contact.attributes }, session: session
    end
    assert_redirected_to :root
  end

  def create_contact_content_fail(session)
    assert_no_difference 'Contact.count' do
      post :create, params: { contact: { name: '' } }, session: session
    end
    assert_template :new
  end

  def show_item_success(session)
    get :show, params: { id: @contact.to_param }, session: session
    assert_response :success
  end

  def show_item_fail(session)
    get :show, params: { id: @contact.to_param }, session: session
    assert_redirected_to session.nil? ? :public : :root
  end

  def edit_item_success(session)
    get :edit, params: { id: @contact.to_param }, session: session
    assert_response :success
  end

  def edit_item_fail(session)
    get :edit, params: { id: @contact.to_param }, session: session
    assert_redirected_to :root
  end

  def update_contact_success(session)
    put :update, params: { id: @contact.to_param,
                           contact: FactoryBot.attributes_for(:valid_contact) }, session: session
    assert_redirected_to contacts_path
  end

  def update_contact_auth_fail(session)
    put :update, params: { id: @contact.to_param, contact: { name: 'Doom' } }, session: session
    assert_redirected_to :root
  end

  def update_contact_content_fail(session)
    put :update, params: { id: @contact.to_param,
                           contact: { cell_phone: 'Doom' } }, session: session
    assert assigns(:contact).invalid?
    assert_template :edit
  end

  test 'should get index' do
    get_index_success @user_session
    get_index_success @peon_user_session
  end

  test "anon can't get index" do
    get_index_fail nil
  end

  test 'should get new' do
    get_new_success @user_session
  end

  test "peon and anon can't get new" do
    get_new_fail(@peon_user_session)
    get_new_fail(nil)
  end

  test 'should create contact' do
    create_contact_success @user_session
  end

  test "can't create contact with bad info" do
    create_contact_content_fail @user_session
  end

  test "peon and anon can't create contact" do
    create_contact_auth_fail(@peon_user_session)
    create_contact_auth_fail(nil)
  end

  test 'should show contact' do
    show_item_success @user_session
    show_item_success @peon_user_session
  end

  test "anon can't show" do
    show_item_fail nil
  end

  test 'should get edit' do
    edit_item_success @user_session
  end

  test "peon and anon can't edit" do
    edit_item_fail @peon_user_session
    edit_item_fail nil
  end

  test 'should update contact' do
    update_contact_success @user_session
  end

  test "peon and anon can't update" do
    update_contact_auth_fail @peon_user_session
    update_contact_auth_fail nil
  end

  test "can't update with bad data" do
    update_contact_content_fail @user_session
  end
end
