class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @title = "Mr X., Sign in please!"
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
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
end
