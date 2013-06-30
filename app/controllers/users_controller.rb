class UsersController < ApplicationController
  before_filter :redirect_if_cannot_admin, except: [:change_password]

  respond_to :html, :json

  # GET /admin/users
  # GET /admin/users.json
  def index
    @title = "Users"
    @q     = User.search params[:q]
    @users = @q.result.page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user           = User.new
    @user.volunteer = Volunteer.find_by_id params[:volunteer_id]

    if params[:realname]
      @user.realname = params[:realname]
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def change_password
    @user = User.find(params[:id])
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user      = User.new(params[:user].reject { |k,v| k == 'volunteer'})
    @volunteer = Volunteer.find_by_id(params[:user][:volunteer])
    @user.volunteer = @volunteer if @volunteer

    flash[:notice] = "User #{@user.name} was successfully created." if @user.save
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user      = User.find(params[:id])
    @volunteer = Volunteer.find_by_id(params[:volunteer])
    @user.volunteer = @volunteer if @volunteer
    flash[:notice] = "User #{@user.name} was successfully updated." if @user.update_attributes(params[:user])
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user, location: users_path
  end

  protected

  def redirect_if_cannot_admin
    unless current_user and current_user.can_admin_users?
      redirect_to public_url
    end
  end
end
