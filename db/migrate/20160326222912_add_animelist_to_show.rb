class AddAnimelistToShow < ActiveRecord::Migration
  def change
    add_column :shows, :animelist_id, :integer
  end
end
