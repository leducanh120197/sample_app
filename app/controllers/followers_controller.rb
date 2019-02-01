class FollowersController < ApplicationController
  before_action :logged_in_user

  def show
    @title = t "followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page]).per Settings.follow_number
    render "users/show_follow"
  end
end
