class MessagesController < ApplicationController
  respond_to :html, :json

  before_filter :find_messages, only: :index
  before_filter :find_message, only: [:show, :edit, :update, :destroy]

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new (params.has_key?(:message) ? message_params : nil)
  end

  # POST /messages
  # POST /messages.json
  def create
    @message      = Message.new message_params
    @message.user = current_user
    flash[:notice] = 'Message was successfully created.' if @message.save
    respond_with @message, location: messages_path
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    flash[:notice] = 'Message was successfully updated.' if @message.update_attributes message_params
    respond_with @message, location: messages_path
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_with @message, location: messages_path
  end

  protected

  def find_message
    @message = Message.find(params[:id])
  end

  def find_messages
    @qc       = Contact.search params[:qc]
    @messages = Message.where(is_active: true).page(params[:page])
  end

  def message_params
    params.require(:message).permit :is_active, :for, :message, :phone_number, :room_number, :hotel, :can_text, :position
  end
end
