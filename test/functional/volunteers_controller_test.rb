require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  setup do
    @user      = FactoryGirl.create :user
    @peon_user = FactoryGirl.create :user
    @role      = FactoryGirl.create :admin_users_role
    @user.roles << @role
    @volunteer    = FactoryGirl.create :valid_volunteer
    @user_session = { user_id: @user.id }
    @peon_session = { user_id: @peon_user.id }
  end

  def get_index_success(session)
    get :index, {}, session
    assert_response :success
    assert_not_nil assigns(:volunteers)
  end

  def get_index_fail(session)
    get :index
    assert_redirected_to :public
    assert_equal nil, assigns(:volunteers)
  end

  def get_new_success(session)
    get :new, {}, session
    assert_not_nil assigns(:volunteer).volunteer_training
    assert_response :success
  end

  def get_new_fail(session)
    get :new, {}, session
    assert_redirected_to :public
  end

  def post_create_success(session)
    assert_difference('Volunteer.count') do
      post :create, { volunteer: FactoryGirl.attributes_for(:valid_volunteer) }, session
    end

    assert_redirected_to volunteer_path(assigns[:volunteer])
  end

  def post_create_auth_fail(session)
    assert_no_difference('Volunteer.count') do
      post :create, { volunteer: @volunteer.attributes }, session
    end

    assert_redirected_to :public
  end

  def get_show_success(session)
    get :show, { id: @volunteer.to_param }, session
    assert_response :success
  end

  def get_show_fail(session)
    get :show, { id: @volunteer.to_param }, session
    assert_redirected_to :public
  end

  def get_edit_success(session)
    get :edit, { id: @volunteer.to_param }, session
    assert_response :success
  end

  def get_edit_fail(session)
    get :edit, { id: @volunteer.to_param }, session
    assert_redirected_to :public
  end

  def put_update_success(session)
    put :update, { id: @volunteer.to_param, volunteer: FactoryGirl.attributes_for(:valid_volunteer) }, session
    assert_redirected_to volunteer_path(@volunteer)
  end

  def put_update_fail(session)
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

  context "five volunteers with radio training" do
    setup do
      @volunteers = FactoryGirl.create_list :valid_volunteer, 5
      @volunteers.each do |v|
        v.volunteer_training.radio = true
        v.volunteer_training.save
        v.reload
      end
    end

    context 'be able to clear all at once' do
      setup do
        get :clear_all_radio_training, {}, @user_session
      end

      should redirect_to :volunteers
      should 'have no radio training' do
        Volunteer.find_each do |v|
          assert !v.volunteer_training.radio
        end
      end
    end
  end


  test "can find an attendee" do
=begin
    get :attendees, { term: "Micha" }, @user_session
    assert_response :success
    assert_equal "Michael", assigns(:list)[0][:first_name]

    get :attendees, { term: "Micha Sco" }, @user_session
    assert_equal "Scott", assigns(:list)[0][:middle_name]

    get :attendees, { term: "Micha Shap" }, @user_session
    assert_equal "Shappe", assigns(:list)[0][:last_name]

    get :attendees, { term: "Shappe" }, @user_session
    assert_equal "Michael", assigns(:list)[0][:first_name]

    get :attendees, { term: "Micha Sco Shap" }, @user_session
    assert_equal "Shappe", assigns(:list)[0][:last_name]
=end
  end

end
