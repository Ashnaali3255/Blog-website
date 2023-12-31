class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])

    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])

    @post = @user.posts.find(params[:post_id])

    @comment = @post.comments.new(comment_params)

    @comment.author_id = current_user.id

    if @comment.save

      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'

    else

      render :new

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
