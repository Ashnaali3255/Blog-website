FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }

    text { Faker::Lorem.paragraph }

    association :author, factory: :user

    comments_counter { 0 }

    likes_counter { 0 }
  end
end
