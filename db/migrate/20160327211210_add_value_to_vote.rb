class AddValueToVote < ActiveRecord::Migration
  def change
    add_column :votes, :value, :integer
    add_column :votes, :type, :string
  end
end
