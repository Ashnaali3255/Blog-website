class Comment < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post

  after_save :update_comments_counter

  private

  def update_comments_counter
    new_comments_count = post.comments.count
    post.update(comments_counter: new_comments_count)
  end
end
