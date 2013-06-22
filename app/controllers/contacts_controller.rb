class ContactsController < ApplicationController
  before_filter :can_write_entries?, only: [:new, :create, :edit, :update]
  before_filter :find_contacts, only: [:index]
  before_filter :find_contact, only: [:show, :edit, :update]

  respond_to :html, :json

  # GET /contacts
  # GET /contacts.json
  def index
     respond_with @contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    respond_with @contact
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_with @contact
  end

  # GET /contacts/1/edit
  def edit
    respond_with @contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    flash[:notice] = 'Contact was successfully created.' if @contact.save
    respond_with @contact, location: contacts_path
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    flash[:notice] = 'Contact was successfully updated.' if @contact.update_attributes(params[:contact])
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
end
