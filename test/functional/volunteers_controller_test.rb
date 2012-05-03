require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @peon_user = FactoryGirl.create :peon
    @role = FactoryGirl.create :admin_users_role
    @user.roles << @role
    @volunteer = FactoryGirl.create :valid_volunteer
    @user_session = { user_id: @user.id }
    @peon_session = { user_id: @peon_user.id }
  end

  def get_index_success( session )
    get :index, {}, session
    assert_response :success
    assert_not_nil assigns(:volunteers)
  end

  def get_index_fail( session )
    get :index
    assert_redirected_to :public
    assert_nil assigns(:volunteers)
  end

  def get_new_success( session )
    get :new, {}, session
    assert_not_nil assigns(:volunteer).volunteer_training
    assert_response :success
  end

  def get_new_fail( session )
    get :new, {}, session
    assert_redirected_to :public
  end

  def post_create_success( session )
    assert_difference('Volunteer.count') do
      post :create, { volunteer: @volunteer.attributes }, session
    end

    assert_redirected_to volunteer_path(assigns(:volunteer))
  end

  def post_create_auth_fail( session )
    assert_no_difference('Volunteer.count') do
      post :create, { volunteer: @volunteer.attributes }, session
    end

    assert_redirected_to :public
  end

  def get_show_success( session )
    get :show, { id: @volunteer.to_param }, session
    assert_response :success
  end

  def get_show_fail( session )
    get :show, { id: @volunteer.to_param }, session
    assert_redirected_to :public
  end

  def get_edit_success( session )
    get :edit, { id: @volunteer.to_param }, session
    assert_response :success
  end

  def get_edit_fail( session )
    get :edit, { id: @volunteer.to_param }, session
    assert_redirected_to :public
  end

  def put_update_success( session )
    put :update, { id: @volunteer.to_param, volunteer: @volunteer.attributes }, session
    assert_redirected_to volunteer_path(assigns(:volunteer))
  end

  def put_update_fail( session )
    put :update, { id: @volunteer.to_param, volunteer: @volunteer.attributes }, session
    assert_redirected_to :public
  end

  test "should get index" do
    get_index_success @user_session
  end

  test "anon and peon cannot get index" do
    get_index_fail @peon_session
    get_index_fail nil
  end

  test "should get new" do
    get_new_success @user_session
  end

  test "anon and peon cannot get new" do
    get_new_fail @peon_session
    get_new_fail nil
  end

  test "should create volunteer" do
    post_create_success @user_session
  end

  test "anon and peon cannot create volunteer" do
    post_create_auth_fail @peon_session
    post_create_auth_fail nil
  end

  test "should show volunteer" do
    get_show_success @user_session
  end

  test "anon and peon cannot show" do
    get_show_fail @peon_session
    get_show_fail nil
  end

  test "should get edit" do
    get_edit_success @user_session
  end

  test "anon and peon cannot edit" do
    get_edit_fail @peon_session
    get_edit_fail nil
  end

  test "should update volunteer" do
    put_update_success @user_session
  end

  test "anon and peon cannot update" do
    put_update_fail @peon_session
    put_update_fail nil
  end

  test "can futz with volunteer training and have it save" do
    victim = FactoryGirl.build :valid_volunteer
    p victim
    p victim.volunteer_training
  end
end
