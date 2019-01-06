require 'test_helper'

class LostAndFoundControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user 
  end
    
  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
  end

end
