class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update destroy correct_user)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.page(params[:page]).per Settings.user_number
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "pls_check_email"
      redirect_to root_url
    else
      flash[:danger] = t "danger"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.micropost_number
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "danger"
      render :edit
    end
  end

  def destroy
    @user.destroy ? flash[:success] = t("user_deleted") : flash[:danger] = t("danger")
    redirect_to users_url
  end

  private

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "pls_log_in"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
