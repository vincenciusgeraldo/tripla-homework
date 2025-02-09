FactoryBot.define do
  factory :sleep_tracker do
    id { SecureRandom.random_number(1_000_000) }
    user_id { user_id }
    sleep_at { sleep_at }
    awake_at { awake_at }
  end
end
