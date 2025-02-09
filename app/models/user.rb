class User < ApplicationRecord
  has_many :sleep_trackers
  has_many :followers
end
