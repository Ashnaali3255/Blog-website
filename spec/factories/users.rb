FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'user_photo.png' }
    bio { Faker::Lorem.sentence }
    posts_counter { 0 }

    # Association with posts
    transient do
      posts_count { 3 } # Number of posts to generate for each user
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, author: user)
    end

    # Other associations with comments and likes could be added here if needed

    factory :user_with_comments_and_likes do
      transient do
        comments_count { 5 } # Number of comments to generate for each user's posts
        likes_count { 10 } # Number of likes to generate for each user's posts
      end

      after(:create) do |user, evaluator|
        user.posts.each do |post|
          create_list(:comment, evaluator.comments_count, post:, author: user)
          create_list(:like, evaluator.likes_count, post:, author: user)
        end
      end
    end
  end
end
