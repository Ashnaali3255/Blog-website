class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def index
    @user_id = params[:user_id]
    @user = User.find(@user_id)
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end
end
