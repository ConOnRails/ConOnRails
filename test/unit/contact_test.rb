require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = FactoryGirl.attributes_for :valid_contact
  end

  test "can create valid contact" do
    Contact.create! @valid_attributes
  end

  test "bad phone number fails" do
    @valid_attributes[:cell_phone]= "llamaface!"
    contact                       = Contact.create @valid_attributes
    assert contact.invalid?, "Phone number should have been rejected"
  end

  test "Empty phone fails" do
    @valid_attributes[:cell_phone] = ""
    contact = Contact.create @valid_attributes
    assert contact.invalid? "Empty phone should have been rejected"
  end

  test "Empty name fails" do
    @valid_attributes[:name] = ""
    contact                  = Contact.create @valid_attributes
    assert contact.invalid?, "Empty name should have been rejected"
  end

end
