class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickName, :null=>false
      t.string :profileUrl
      t.string :username, :null=>false
      t.string :passwordHash, :null=>false
      t.string :salt, :null=>false
      t.string :email, :null=>false
      t.boolean :emailNotifications, :null=>false, :default=>true
      t.boolean :isAdmin, :null=>false, :default=>false
      t.timestamps
    end
  end
end
