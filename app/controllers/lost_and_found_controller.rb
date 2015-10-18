class LostAndFoundController < ApplicationController
  skip_authorization_check

  respond_to :html, only: :index
  before_action -> { @title = 'Lost and Found' }
end
