require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @user      = FactoryGirl.create :user
    @contact   = FactoryGirl.create :valid_contact
    @user_session      = { user_id: @user.id }
  end

  def get_index_success(session)
    get :index, { }, session
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  def get_index_fail(session)
    get :index, { }, session
    assert_redirected_to :public
  end

  def get_new_success(session)
    get :new, { }, session
    assert_response :success
  end

  def get_new_fail(session)
    get :new, { }, session
    assert_redirected_to :public
  end

  def create_contact_success(session)
    assert_difference('Contact.count') do
      post :create, { contact: FactoryGirl.attributes_for(:valid_contact) }, session
    end

    assert_redirected_to contacts_path
  end

  def create_contact_auth_fail(session)
    assert_no_difference 'Contact.count' do
      post :create, { contact: @contact.attributes }, session
    end
    assert_redirected_to :public
  end

  def create_contact_content_fail(session)
    assert_no_difference 'Contact.count' do
      post :create, { contact: { name: "" } }, session
    end
    assert_template :new
  end

  def show_item_success(session)
    get :show, { id: @contact.to_param }, session
    assert_response :success
  end

  def show_item_fail(session)
    get :show, { id: @contact.to_param }, session
    assert_redirected_to :public
  end

  def edit_item_success(session)
    get :edit, { id: @contact.to_param }, session
    assert_response :success
  end

  def edit_item_fail(session)
    get :edit, { id: @contact.to_param }, session
    assert_redirected_to :public
  end

  def update_contact_success(session)
    put :update, { id: @contact.to_param, contact: FactoryGirl.attributes_for(:valid_contact) }, session
    assert_redirected_to contacts_path
  end

  def update_contact_auth_fail(session)
    put :update, { id: @contact.to_param, contact: { name: "Doom" } }, session
    assert_redirected_to :public
  end

  def update_contact_content_fail(session)
    put :update, { id: @contact.to_param, contact: { cell_phone: "Doom" } }, session
    assert assigns(:contact).invalid?
    assert_template :edit
  end

  test "should get index" do
    get_index_success @user_session
  end

  test "anon can't get index" do
    get_index_fail nil
  end

  test "should get new" do
    get_new_success @user_session

  end

  test "anon can't get new" do
    get_new_fail(nil)
  end

  test "should create contact" do
    create_contact_success @user_session
  end

  test "can't create contact with bad info" do
    create_contact_content_fail @user_session
  end

  test "anon can't create contact" do
    create_contact_auth_fail(nil)
  end

  test "should show contact" do
    show_item_success @user_session
  end

  test "anon can't show" do
    show_item_fail nil
  end

  test "should get edit" do
    edit_item_success @user_session

  end

  test "anon can't edit" do
    edit_item_fail nil
  end

  test "should update contact" do
    update_contact_success @user_session

  end

  test "anon can't update" do
    update_contact_auth_fail nil
  end

  test "can't update with bad data" do
    update_contact_content_fail @user_session
  end
end
