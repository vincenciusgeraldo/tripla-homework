FactoryBot.define do
  factory :user do
    id { SecureRandom.random_number(1_000_000) }
    name { "John Doe" }
  end
end
