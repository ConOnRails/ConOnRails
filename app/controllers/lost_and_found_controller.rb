# frozen_string_literal: true

class LostAndFoundController < ApplicationController
  skip_after_action :verify_policy_scoped

  respond_to :html, only: :index
  before_action -> { @title = 'Lost and Found' }

  def index
    authorize :lost_and_found
  end
end
