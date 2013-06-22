class MessagesController < ApplicationController
  respond_to :html, :json

  # GET /messages
  # GET /messages.json
  def index
    @qc       = Contact.search params[:qc]
    @messages = Message.where(is_active: true).page(params[:page])
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new(params[:message])
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message      = Message.new(params[:message])
    @message.user = current_user
    flash[:notice] = 'Message was successfully created.' if @message.save
    respond_with @message, location: messages_path
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])
    flash[:notice] = 'Message was successfully updated.' if @message.update_attributes(params[:message])
    respond_with @message, location: messages_path
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_with @message, location: messages_path
  end
end
