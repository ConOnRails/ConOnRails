class LostAndFoundController < ApplicationController
  load_and_authorize_resource

  respond_to :html, only: :index
  before_action -> { @title = 'Lost and Found' }
end
