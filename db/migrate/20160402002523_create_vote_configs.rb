class CreateVoteConfigs < ActiveRecord::Migration
  def change
    create_table :vote_configs do |t|
      t.integer :stop_voting_day
      t.string :stop_voting_time
      t.string :timezone

      t.timestamps null: false
    end
  end
end
