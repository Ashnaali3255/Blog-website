class LikesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @post.likes.new
    @like.author_id = current_user.id

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully liked.'
    else
      render :new
    end
  end
end
