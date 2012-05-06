class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, except: [:banner]

  def banner
    render partial: 'banner'
  end

  private

  def is_authenticated?
    if session[:user_id] != nil
      return true
    else
      return false
    end
  end

  def can_admin_anything?
    ret = false
    if is_authenticated?
      user = User.find session[:user_id]
      ret  = user.can_admin_anything?
    end
    return ret
  end

  def can_write_entries?
    redirect_to :public unless current_user and current_user.write_entries?
  end

  def can_admin_users?
    redirect_to :public unless current_user and current_user.can_admin_users?
  end

  def can_admin_radios?
    redirect_to :public unless current_user and current_user.can_admin_radios?
  end

  def can_assign_radios?
    redirect_to :public unless current_user and current_user.can_assign_radios?
  end

  def require_login
    redirect_to :public unless is_authenticated?
  end

  def current_user
    if is_authenticated?
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  helper_method :can_write_entries?, :is_authenticated?, :can_admin_anything?, :current_user, :num_events
end
