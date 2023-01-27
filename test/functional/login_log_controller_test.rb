# frozen_string_literal: true

require 'test_helper'

class LoginLogControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @role = FactoryBot.create :read_audits_role
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role_name: @role.name }
  end

  test 'should get index' do
    get :index, session: @user_session

    assert_response :success
  end
end
