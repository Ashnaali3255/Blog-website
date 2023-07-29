require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_presence_of(:comments_counter) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:likes_counter) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#recent_comments' do
    it 'returns the 5 most recent comments' do
      post = create(:post)
      comments = create_list(:comment, 10, post:)

      recent_comments = post.recent_comments

      expect(recent_comments.length).to eq(5)
      expect(recent_comments).to eq(comments.last(5).sort_by(&:created_at).reverse)
    end
  end

  describe '#update_posts_counter' do
    it 'updates the posts_counter attribute for the author' do
      post = create(:post, author: user)

      expect { post.save }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
