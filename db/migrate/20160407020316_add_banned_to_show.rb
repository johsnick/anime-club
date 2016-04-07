class AddBannedToShow < ActiveRecord::Migration
  def change
    add_column :shows, :banned, :boolean, default: false
  end
end
