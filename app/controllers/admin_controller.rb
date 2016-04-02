class AdminController < ApplicationController
  skip_authorization_check only: :index

  def index
    redirect_to :root unless can_admin_anything?
  end

end
