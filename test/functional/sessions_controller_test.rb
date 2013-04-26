require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :write_entries_role
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should have the right title" do
    get :new
    assert_select 'title', "Con On Rails | Mr X., Sign in please!"
  end

  test "anon cannot create session" do
    get :create
    assert_not_nil flash[:notice]
    assert_redirected_to :root
  end

  test "user can create session" do
    get :create, { name: @user.name, password: @user.password }
    assert_equal "Logged in!", flash[:notice]
    assert_not_nil session[:user_id]
    assert_equal @user.id, session[:user_id]
    assert_redirected_to :root
  end

  test "can destroy session" do
    get :create, { name: @user.name, password: @user.password }
    assert_not_nil session[:user_id]
    assert_equal @user.id, session[:user_id]
    get :destroy, { }, { user_id: @user.id }
    assert_nil session[:user_id]
    assert_redirected_to :root
  end

  test "can get roles for a given username" do
    @user.roles << @role
    @user.save!

    get :getroles, { format: :js, name: @user.name }
    assert_not_nil assigns :rolenames
    assert_equal @role.name, assigns(:rolenames)[0]
  end
end
