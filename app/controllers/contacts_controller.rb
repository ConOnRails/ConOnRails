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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  can_text   :boolean          default(FALSE)
#  position   :string(255)
#

class ContactsController < ApplicationController
  #before_filter :can_write_entries?, only: [:new, :create, :edit, :update]
  before_filter :find_contacts, only: [:index]
  #before_filter :find_contact, only: [:show, :edit, :update]
  load_and_authorize_resource

  respond_to :html, :json

  # GET /contacts
  # GET /contacts.json
  def index
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new contact_params
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

  def find_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit :name, :cell_phone, :department, :position, :hotel, :hotel_room, :can_text
  end

end
