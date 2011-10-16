class SessionsController < ApplicationController
  def new
    @title = "Mr X., Sign in please!"
  end
  
  def create
    render 'new'
  end

  def destroy
    @title = "Goodbye!"
  end
end
