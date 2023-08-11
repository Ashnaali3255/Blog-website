class UsersController < ApplicationController
  def show
    @user = User.includes(posts: [:comments]).find(params[:id])
    @most_recent_posts = @user.recent_posts
  end

  def index
    @users = User.all
  end
end
