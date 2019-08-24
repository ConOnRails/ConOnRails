# frozen_string_literal: true

class LoginLogController < ApplicationController
  before_action :can_read_audits?

  def index
    @logins = LoginLog.all
  end
end
