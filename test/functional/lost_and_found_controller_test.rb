require 'test_helper'

class LostAndFoundControllerTest < ActionController::TestCase
  setup do
    @user = users :one 
  end
    
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end

end
