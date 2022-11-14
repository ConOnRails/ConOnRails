# frozen_string_literal: true

require('test_helper')

class RadiosControllerTest < ActionController::TestCase
  setup do
    @radio = FactoryBot.build(:valid_blue_radio)
    @user  = FactoryBot.create(:user)
    @role  = FactoryBot.create(:admin_radios_role)
    @department = FactoryBot.create(:good_department)
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role_name: @role.name }
    @volunteer = FactoryBot.create(:valid_volunteer)
    @blue = FactoryBot.create(:blue_man_group)
  end

  test 'should get index' do
    get :index, session: @user_session
    assert_response :success
    assert_not_nil assigns(:radios)
  end

  test 'should get new' do
    get :new, session: @user_session
    assert_response :success
  end

  test 'should create radio' do
    assert_difference('Radio.count') do
      post :create,
           params: { radio: FactoryBot.attributes_for(:valid_blue_radio, radio_group_id: @blue.id) },
           session: @user_session
    end

    assert_redirected_to radios_path
  end

  test 'should show radio' do
    @radio.save!
    get :show, params: { id: @radio.to_param }, session: @user_session
    assert_response :success
  end

  test 'should get edit' do
    @radio.save!
    get :edit, params: { id: @radio.to_param }, session: @user_session
    assert_response :success
  end

  test 'should update radio' do
    @radio.save!
    put :update,
        params: {
          id: @radio.to_param,
          radio: { notes: Faker::Lorem.paragraph }
        },
        session: @user_session
    assert_redirected_to radios_path
  end

  test 'should destroy radio' do
    @radio.save!
    assert_difference('Radio.count', -1) do
      delete :destroy, params: { id: @radio.to_param }, session: @user_session
    end

    assert_redirected_to radios_path
  end

  test 'should get checkout form' do
    @radio.save!
    get :checkout, params: { id: @radio.to_param }, session: @user_session
    assert_response :success
  end

  test 'can search volunteers' do
    @radio.save!
    post :search_volunteers,
         xhr: true,
         params: {
           first_name: @volunteer.first_name,
           last_name: @volunteer.last_name,
           radio: @radio.to_param
         },
         session: @user_session
    assert_response :success
  end

  test 'can search volunteers case insensitive' do
    @radio.save!
    post :search_volunteers,
         xhr: true,
         params: {
           first_name: @volunteer.first_name.downcase,
           last_name: @volunteer.last_name.upcase,
           radio: @radio.to_param
         },
         session: @user_session
    assert_response :success
  end

  test 'can select department' do
    @radio.save!
    get :select_department,
        xhr: true,
        params: {
          id: @radio.to_param,
          volunteer: @volunteer.to_param
        },
        session: @user_session
    assert_response :success
  end
end
