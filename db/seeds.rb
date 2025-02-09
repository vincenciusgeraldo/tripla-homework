# db/seeds.rb

# Create users
user1 = User.create!(name: "Alice")
user2 = User.create!(name: "Bob")
user3 = User.create!(name: "Charlie")

# Create followers
Follower.create!(user_id: user1.id, follower_user_id: user2.id)
Follower.create!(user_id: user1.id, follower_user_id: user3.id)
Follower.create!(user_id: user2.id, follower_user_id: user1.id)

# Create sleep trackers for users
10.times do |i|
  SleepTracker.create!(user_id: user1.id, sleep_at: (i+1).days.ago, awake_at: (i+1).days.ago + 8.hours, duration: 8.hours)
  SleepTracker.create!(user_id: user2.id, sleep_at: (i+1).days.ago, awake_at: (i+1).days.ago + 7.hours, duration: 7.hours)
  SleepTracker.create!(user_id: user3.id, sleep_at: (i+1).days.ago, awake_at: (i+1).days.ago + 6.hours, duration: 6.hours)
end
