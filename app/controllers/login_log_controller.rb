class LoginLogController < ApplicationController
  load_and_authorize_resource

  def index
    @logins = @login_logs # Adapt from cancancan magic to our current views
  end

end
