# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :find_contacts, only: [:index]
  before_action :find_contact, only: %i[show edit update]

  respond_to :html, :json

  # GET /contacts
  # GET /contacts.json
  def index; end

  # GET /contacts/1
  # GET /contacts/1.json
  def show; end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
    authorize @contact
  end

  # GET /contacts/1/edit
  def edit; end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new contact_params
    authorize @contact

    flash[:notice] = 'Contact was successfully created.' if @contact.save
    respond_with @contact, location: contacts_path
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    flash[:notice] = 'Contact was successfully updated.' if @contact.update contact_params
    respond_with @contact, location: contacts_path
  end

  protected

  def find_contacts
    @q        = policy_scope(Contact).ransack params[:q]
    @contacts = @q.result.page(params[:page])
    authorize @contacts
  end

  def find_contact
    @contact = Contact.find(params[:id])
    authorize @contact
  end

  def contact_params
    params.permit(:q, :page)
    params.require(:contact).permit :name, :cell_phone, :department, :position, :hotel, :hotel_room, :can_text
  end
end
