class AddVoteCountToShow < ActiveRecord::Migration
  def change
    add_column :shows, :vote_count, :integer, default: 0
  end
end
