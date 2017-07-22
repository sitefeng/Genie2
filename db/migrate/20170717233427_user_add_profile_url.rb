class UserAddProfileUrl < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :lastName, :string
    rename_column :users, :firstName, :nickName
    add_column :users, :profileUrl, :string
  end
end
