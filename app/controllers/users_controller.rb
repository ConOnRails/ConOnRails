# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :html, :json

  before_action :find_user, only: %i[show edit update destroy change_password]
  before_action :find_users, only: :index

  def index; end
  def show; end

  def new
    @user = User.new
    authorize @user

    @user.volunteer = Volunteer.find_by id: params[:volunteer_id]
    @user.realname = params[:realname] if params[:realname]
  end

  def change_password; end

  # GET /users/new
  # GET /users/new.json
  def edit; end

  # POST /admin/users
  # POST /admin/users.json
  def create # rubocop:disable Metrics/AbcSize
    # user_params = params[:user].reject { |k, v| k == 'volunteer' }
    @volunteer = Volunteer.find_by(id: params[:user][:volunteer])
    @user = @volunteer&.build_user(user_params) || User.new(user_params)

    authorize @user
    @user.save
    @volunteer&.save

    flash.now[:notice] = "User #{@user.username} was successfully created." if @user.persisted?
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update(user_params) && update_volunteer
      flash.now[:notice] = "User #{@user.username} was successfully updated."
    end

    respond_with @user, location: update_success_path
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_with @user, location: users_path
  end

  protected

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end

  def find_users
    @q = policy_scope(User).ransack params[:q]
    @users = @q.result.page(params[:page])
    authorize @users
  end

  def update_success_path
    if request.referer.present? &&
       URI(request.referer).path == change_password_user_path(@user)
      root_path
    else
      user_path(@user)
    end
  end

  def update_volunteer
    @volunteer = Volunteer.find_by(id: params[:volunteer_id])
    return true if @volunteer.blank?

    if @volunteer.present? && (@volunteer.user_id.blank? || (@volunteer.user_id != @user.id))
      @volunteer.update(user_id: @user.id)
    end
  end

  def user_params
    params.require(:user).permit :username, :realname, :password, :password_confirmation,
                                 { role_ids: [] }, :volunteer_id
  end
end
