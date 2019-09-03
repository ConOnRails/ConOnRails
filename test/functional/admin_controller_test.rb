# frozen_string_literal: true

require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @role = FactoryBot.build :admin_users_role
    @user.roles << @role

    @peon_user = FactoryBot.create :user
    @peon_role = FactoryBot.build :role
    @peon_user.roles << @peon_role
  end

  test 'admin user should get index' do
    get :index, session: { user_id: @user.id }
    assert_response :success
  end

  test 'peon user should not get index' do
    get :index
    assert_redirected_to public_url
  end
end
