class CreateFollowers < ActiveRecord::Migration[8.0]
  def change
    create_table :followers do |t|
      t.integer :user_id
      t.integer :follower_user_id

      t.timestamps
    end
  end
end
