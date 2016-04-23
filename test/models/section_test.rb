require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should have_many :event_sections
  should have_many(:events).through :event_sections
  should have_many :section_users
  should have_many(:users).through :section_users
  should validate_presence_of :name
  should validate_uniqueness_of :name

  context '#user_ids=' do
    setup do
      @users = create_list :user, 3
      subject.name = 'Doom' # Appease the validator
    end

    should 'add users to the section' do
      assert_difference('SectionUser.count', 3) do
        subject.user_ids = @users.collect(&:id)
        subject.save!
      end
    end
  end
end
