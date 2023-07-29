require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'associations' do
    it { should belong_to(:user).with_foreign_key(:author_id) }
    it { should belong_to(:post) }
  end

  describe 'after_save callback' do
    it 'updates the comments_counter of the associated post' do
      comment = build(:comment, user:, post:)
      expect do
        comment.save
      end.to change { post.reload.comments_counter }.from(0).to(1)
    end
  end
end
