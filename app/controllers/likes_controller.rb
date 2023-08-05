class LikesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @like = current_user.likes.build(post: @post)
  
      if @like.save
        update_likes_counter # Call the method to update likes_counter in the associated post.
        redirect_to @post, notice: 'Post liked successfully.'
      else
        redirect_to @post, alert: 'Unable to like the post.'
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      @like = current_user.likes.find_by(post: @post)
  
      if @like&.destroy
        update_likes_counter # Call the method to update likes_counter in the associated post.
        redirect_to @post, notice: 'Post unliked successfully.'
      else
        redirect_to @post, alert: 'Unable to unlike the post.'
      end
    end
  
    private
  
    # Method to update the likes_counter in the associated post.
    def update_likes_counter
      post.update(likes_counter: post.likes.count)
    end
  end
  