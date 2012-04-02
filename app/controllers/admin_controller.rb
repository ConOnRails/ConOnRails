class AdminController < ApplicationController
  before_filter :redirect_if_cannot_admin
  
  def redirect_if_cannot_admin
    unless can_admin_anything?
      redirect_to public_url
    end
  end
  
  def index
  end

end
