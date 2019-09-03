# frozen_string_literal: true

class LostAndFoundController < ApplicationController
  respond_to :html, only: :index
  before_action -> { @title = 'Lost and Found' }
end
