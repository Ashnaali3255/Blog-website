class UsersController < ApplicationController
  def show
    @user_id = params[:id]
    @user = User.find(@user_id)
    @most_recent_posts = @user.recent_posts
  end

  def index
    @user = User.all
  end
end
