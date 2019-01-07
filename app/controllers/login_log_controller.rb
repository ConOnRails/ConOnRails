class LoginLogController < ApplicationController
  before_filter :can_read_audits?

  def index
    @logins = LoginLog.all
  end
end
