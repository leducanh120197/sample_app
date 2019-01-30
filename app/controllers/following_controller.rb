class FollowingController < ApplicationController
  before_action :logged_in_user

  def show
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following.page(params[:page]).per Settings.follow_number
    render "users/show_follow"
  end
end
