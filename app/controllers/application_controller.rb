class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization except: :banner

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to public_url, :alert => exception.message
  end

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
      ret = user.can_admin_anything?
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

  def can_assign_duty_board_slots?
    redirect_to :public unless current_user and current_user.can_assign_duty_board_slots?
  end

  def can_read_audits?
    redirect_to :public unless current_user and current_user.can_read_audits?
  end

  def can_read_secure?
    redirect_to :root unless current_user and current_user.can_read_secure?
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
    Role.find_by(name: current_role_name)
  end

  def current_role_name
    session[:current_role_name] if is_authenticated?
  end

  def limit_by_convention(query)
    return query if params[:convention] == 'all' || params[:show_older] == 'true' || get_convention.blank?
    query.where { |x| (x.created_at >= get_convention.start_date) & (x.created_at <= get_convention.end_date) }
  end

  def limit_by_date_range(query)
    return query if params[:from_date].blank? && params[:to_date].blank?
    query = query.where { |x| x.created_at >= params[:from_date] } if params[:from_date].present?
    query = query.where { |x| x.created_at <= params[:to_date] } if params[:to_date].present?
    query
  end

  def get_convention
    @con ||= if params[:convention].present?
               Convention.find params[:convention]
             else
               Convention.current_convention if params[:convention].blank?
             end
  end

  helper_method :can_write_entries?, :is_authenticated?, :can_admin_anything?, :current_user, :current_role, :current_role_name
end
