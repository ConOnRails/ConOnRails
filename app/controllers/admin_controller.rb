class AdminController < ApplicationController
  before_filter :redirect_if_cannot_admin

  def redirect_if_cannot_admin
    redirect_to public_url unless can_admin_anything?
  end

  def index
  end

end
