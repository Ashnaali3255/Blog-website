class PostsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @user = User.find(@user_id)
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user_id = params[:user_id]
    @post_id = params[:id]
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
