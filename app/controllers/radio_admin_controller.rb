class RadioAdminController < ApplicationController
  skip_authorization_check
  def index
    redirect_to :root unless current_user && can?(:index, Radio)
  end
end
