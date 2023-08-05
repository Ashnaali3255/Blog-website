class CommentsController < ApplicationController
    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    end
  
    def create
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.build(comment_params)
      @comment.post = @post
  
      if @comment.save
        update_comments_counter # Call the method to update comments_counter in the associated post.
        redirect_to @post, notice: 'Comment was successfully added.'
      else
        render :new
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  
    # Method to update the comments_counter in the associated post.
    def update_comments_counter
      new_comments_count = @post.comments.count
      @post.update(comments_counter: new_comments_count)
    end
  end
  