class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:ranger] = t "not_found"
    redirect_to signup_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "success"
      redirect_to @user
    else
      flash[:ranger] = t "ranger"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
