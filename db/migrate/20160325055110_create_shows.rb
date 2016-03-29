class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :photo
      t.timestamps null: false
    end
  end
end
