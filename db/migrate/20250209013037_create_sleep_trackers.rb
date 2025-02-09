class CreateSleepTrackers < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_trackers do |t|
      t.integer :user_id
      t.timestamp :sleep_at
      t.timestamp :awake_at
      t.integer :duration

      t.timestamps
    end
  end
end
