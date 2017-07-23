class UserAddLoginFields < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, :null=>false
    add_column :users, :passwordHash, :string, :null=>false
    add_column :users, :salt, :string, :null=>false
    add_column :users, :email, :string, :null=>false
    add_column :users, :emailNotifications, :boolean, :null=>false, :default=>true
    add_column :users, :isAdmin, :boolean, :null=>false, :default=>false
  end
end
