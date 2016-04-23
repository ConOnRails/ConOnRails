class UsersController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

  before_filter :find_users, only: :index
 # before_filter :redirect_if_cannot_admin, except: [:change_password]

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.volunteer = Volunteer.find_by_id params[:volunteer_id]

    if params[:realname]
      @user.realname = params[:realname]
    end
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    # user_params = params[:user].reject { |k, v| k == 'volunteer' }
    @volunteer = Volunteer.find_by_id(params[:user][:volunteer])

    if @volunteer.present?
      @user = @volunteer.create_user user_params
      @volunteer.save
    else
      @user = User.create user_params
    end
    flash[:notice] = "User #{@user.username} was successfully created." if @user.persisted?
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(user_params) && update_volunteer
      flash[:notice] = "User #{@user.username} was successfully updated."
    end

    respond_with @user, location: get_update_success_path
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_with @user, location: users_path
  end

  protected

  def find_users
    @q = User.search params[:q]
    @users = @q.result.page(params[:page])
  end

  def get_update_success_path
    if URI(request.referrer).path == change_password_user_path(@user)
      root_path
    else
      user_path(@user)
    end
  end

  def redirect_if_cannot_admin
    unless current_user && (current_user.can_admin_users? || current_user.id == @user.try(:id))
      redirect_to public_url
    end
  end

  def update_volunteer
    @volunteer = Volunteer.find_by_id(params[:volunteer_id])
    return true if @volunteer.blank?
    if @volunteer.present? and (@volunteer.user_id.blank? or @volunteer.user_id != @user.id)
      @volunteer.update_attribute(:user_id, @user.id)
    end
  end

  def user_params
    params.require(:user).permit :username, :realname, :password, :password_confirmation, { role_ids: [] }, { section_ids: []}, :volunteer_id
  end

end
