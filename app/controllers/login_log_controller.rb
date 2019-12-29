# frozen_string_literal: true

class LoginLogController < ApplicationController
  def index
    @logins = policy_scope(LoginLog).all
    authorize @logins
  end
end
