class LoginLogController < ApplicationController
  load_and_authorize_resource

  def index
    @logins = @log_in_logs
  end

end
