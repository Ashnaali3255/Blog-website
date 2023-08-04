class PostsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @user = User.find(@user_id)
    @all_posts = @user.posts.includes(:user, comments: :user)
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
