class UserNameNonNull < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :nickName, :string, :null=>false
  end
end
