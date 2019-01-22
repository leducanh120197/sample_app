class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      if user.activated?
        acc_activated user
      else
        acc_not_activated
      end
    else
      flash.now[:danger] = t "invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def acc_activated user
    log_in user
    params[:session][:remember_me] == Settings.string_one ? remember(user) : forget(user)
    redirect_back_or user
  end

  def acc_not_activated
    flash[:warning] = t "account_not_activated"
    redirect_to root_url
  end
end
