class SleepTracker < ApplicationRecord
  belongs_to :user

  def is_completed?
    self.awake_at.present?
  end
end
