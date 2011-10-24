class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_login
  
  private
  
  def is_authenticated?
     if session[:user_id] != nil
       return true
     else
       return false
     end
   end
  
  def require_login
    unless is_authenticated?
      redirect_to public_url
    end
  end
  
  def current_user
    if is_authenticated?
      return User.find(session[:user_id])
    else
      return nil
    end
  end
  
  helper_method :is_authenticated?, :current_user
end
