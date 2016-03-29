class RenameNicknameToUserNameinUser < ActiveRecord::Migration
  def change
    rename_column :users, :nickname, :username
    change_column :users, :username, :string, unique: true
  end
end
