# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include Rails.application.routes.url_helpers

  protect_from_forgery

  before_action :require_login, except: [:banner]
  after_action :verify_authorized, except: %i[index banner]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def banner
    render json: {
      active: Event.current_convention.num_active,
      active_secure: Event.current_convention.num_active_secure,
      emergency: Event.current_convention.num_active_emergencies,
      medical: Event.current_convention.num_active_medicals,
      logo_url: helpers.image_path("ciab-logo-trans.png"),
      role: current_role_name,
      user_name: current_user&.username,
      user_url: if current_user.present?
          helpers.user_path(current_user)
        end
    }
  end

  private

  def is_authenticated?
    !session[:user_id].nil?
  end

  def can_admin_anything?
    ret = false
    if is_authenticated?
      user = User.find session[:user_id]
      ret = user.can_admin_anything?
    end
    ret
  end

  def user_not_authorized
    redirect_to :root
  end

  def require_login
    redirect_to :public unless is_authenticated?
  end

  def current_user
    User.find(session[:user_id]) if is_authenticated?
  end

  def current_role
    Role.find_by(name: current_role_name)
  end

  def current_role_name
    session[:current_role_name] if is_authenticated?
  end

  def limit_by_convention(query, table: 'events')
    if params[:convention] == 'all' || params[:show_older] == 'true' || get_convention.blank?
      return query
    end

    query.where("#{table}.created_at >= ?", get_convention.start_date)
         .where("#{table}.created_at <= ?", get_convention.end_date)
  end

  def limit_by_date_range(query)
    date_params = params.permit(:from_date, :to_date)
    return query if date_params[:from_date].blank? && date_params[:to_date].blank?

    if date_params[:from_date].present?
      query = query.where('created_at >= ?',
                          date_params[:from_date])
    end
    query = query.where('created_at <= ?', date_params[:to_date]) if date_params[:to_date].present?
    query
  end

  def get_convention
    @con ||= if params[:convention].present?
               Convention.find params[:convention]
             elsif params[:convention].blank?
               Convention.current_convention
             end
  end

  helper_method :can_write_entries?, :is_authenticated?, :can_admin_anything?, :current_user,
                :current_role, :current_role_name
end
