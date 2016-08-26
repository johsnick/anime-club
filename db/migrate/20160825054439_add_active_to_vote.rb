class AddActiveToVote < ActiveRecord::Migration
  def change
    add_column :votes, :active, :boolean
  end
end
