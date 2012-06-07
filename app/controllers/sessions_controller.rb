class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create, :getroles]

  def new
    @title = "Mr X., Sign in please!"
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      session[:current_role] = params[:role]
      redirect_to root_url, notice: "Logged in!"
    else
      redirect_to root_url, notice: "Invalid email or password"
    end
  end

  def destroy
    @title            = "Goodbye!"
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def getroles
    begin
      @rolenames = User.find_by_name(params[:name]).roles.collect { |r| r.name }
    rescue NoMethodError
      @rolenames = []
    end
  end
end
