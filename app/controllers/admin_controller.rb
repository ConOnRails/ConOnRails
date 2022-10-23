# frozen_string_literal: true

class AdminController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    authorize :admin
  end
end
