class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, except: [:banner]

  def banner
    render partial: 'banner'
  end

  private

  def is_authenticated?
    if session[:user_id] != nil
      true
    else
      false
    end
  end

  def can_admin_anything?
    ret = false
    if is_authenticated?
      user = User.find session[:user_id]
      ret  = user.can_admin_anything?
    end
    ret
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

  def can_admin_or_assign_radios?
    redirect_to :public unless current_user and (current_user.can_assign_radios? or current_user.can_admin_radios?)
  end

  def can_admin_duty_board?
    redirect_to :public unless current_user and current_user.can_admin_duty_board?
  end

  def can_read_audits?
    redirect_to :public unless current_user and current_user.can_read_audits?
  end

  def require_login
    redirect_to :public unless is_authenticated?
  end

  def current_user
    if is_authenticated?
      User.find(session[:user_id])
    else
      nil
    end
  end

  def current_role
    session[:current_role] if is_authenticated?
  end

  def limit_by_convention(query)
    return query if params[:convention].blank? || params[:convention] == 'all'

    con = Convention.find params[:convention]
    query.where { |x| (x.created_at >= con.start_date) & (x.created_at <= con.end_date) }
  end

  helper_method :can_write_entries?, :is_authenticated?, :can_admin_anything?, :current_user, :current_role
end
