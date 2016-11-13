require 'test_helper'

class BlogTest < ActionDispatch::IntegrationTest

  test 'back button displays root' do
    jsDriver do
      # @admin      = FactoryGirl.create :user
      # @admin_role = FactoryGirl.create :superuser_role
      # @admin.roles << @admin_role
      # @admin.save!

      # sign_in @admin, @admin_role
      visit '/' 
      # page.evaluate_script('window.history.back()')
    end
  end

end