class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create, :getroles, :set_index_filter, :clear_index_filter]
  skip_authorization_check only: [:new, :create, :getroles, :set_index_filter, :clear_index_filter]

  private
  def ip()
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  public

  def new
    @title = "Mr X., Sign in please!"
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) && setup_session(user)
      flash[:notice] =  "Logged in!"
    else
      log_failure
      flash[:notice] = "Invalid username or password"
    end
    redirect_to root_url
  end

  def destroy
    @title = "Goodbye!"
    LoginLog.create! user_name: (current_user ? current_user.username : "nobody"),
                     role_name: current_role_name, comment: :logout, ip: ip
    session[:user_id] = nil
    redirect_to public_url, notice: "Logged out!"
  end

  def getroles
    begin
      @rolenames = User.find_by(username: params[:username]).roles.collect { |r| r.name }
    rescue NoMethodError
      @rolenames = []
    end
  end

  def set_index_filter
    session[:index_filter] = sanitize_flags params[:index_filter]
    redirect_to public_url
  end

  def clear_index_filter
    session[:index_filter] = nil
    redirect_to public_url
  end

  protected

  def setup_session(user)
    reset_session
    unless user.roles.pluck(:name).include? params[:role]
      user.errors.add(:role, 'The role you tried to log in with is not one assigned to you!')
      return false
    end
    session[:user_id]      = user.id
    session[:current_role_name] = params[:role]
    LoginLog.create! user_name: user.username, role_name: params[:role], comment: :success, ip: ip()
  end

  def log_failure
    LoginLog.create! user_name: params[:username], role_name: params[:role], comment: :failure, ip: ip()
  end

  def sanitize_flags(flags)
    flags.select { |f| Event.flags.include?(f.to_s) }
  end
end
