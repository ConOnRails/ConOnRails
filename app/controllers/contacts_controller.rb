# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  department :string(255)
#  cell_phone :string(255)
#  hotel      :string(255)
#  hotel_room :integer
#  created_at :datetime
#  updated_at :datetime
#  can_text   :boolean          default(FALSE)
#  position   :string(255)
#

class ContactsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_contacts, only: [:index]

  respond_to :html, :json

  # POST /contacts
  # POST /contacts.json
  def create
    flash[:notice] = 'Contact was successfully created.' if @contact.save
    respond_with @contact, location: contacts_path
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    flash[:notice] = 'Contact was successfully updated.' if @contact.update_attributes contact_params
    respond_with @contact, location: contacts_path
  end

  protected

  def find_contacts
    @q        = Contact.search params[:q]
    @contacts = @q.result.page(params[:page])
  end

  def contact_params
    params.require(:contact).permit :name, :cell_phone, :department, :position, :hotel, :hotel_room, :can_text
  end

end
