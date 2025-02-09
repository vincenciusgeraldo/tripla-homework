FactoryBot.define do
  factory :follower do
    id { SecureRandom.random_number(1_000_000) }
    user_id { user_id }
    follower_user_id { follower_user_id }
  end
end
