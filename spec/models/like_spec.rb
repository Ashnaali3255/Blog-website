require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'after_save :update_likes_counter' do
    let!(:post) { create(:post) }
    let!(:user) { create(:user) }

    it 'updates the likes_counter on the associated post' do
      like = build(:like, post:, user:)
      expect { like.save }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
