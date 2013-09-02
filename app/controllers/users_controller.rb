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
    user_params = params[:user].reject { |k, v| k == 'volunteer' }
    @volunteer = Volunteer.find_by_id(params[:user][:volunteer])

    if @volunteer.present?
      @user = @volunteer.create_user user_params
      @volunteer.save
    else
      @user = User.create user_params
    end
    flash[:notice] = "User #{@user.name} was successfully created." if @user.persisted?
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user]) && update_volunteer
      flash[:notice] = "User #{@user.name} was successfully updated."
    end

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

  def update_volunteer
    @volunteer = Volunteer.find_by_id(params[:volunteer])
    if @volunteer.present? and (@volunteer.user_id.blank? or @volunteer.user_id != @user.id)
      @volunteer.update_attribute(:user_id, @user.id)
    end
  end
end
