class AddActiveToVoteConfig < ActiveRecord::Migration
  def change
    add_column :vote_configs, :active, :boolean
  end
end
