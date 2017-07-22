class CreateUserPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_posts do |t|
      t.integer :userId, :null=>false
      t.integer :questionId, :null=>false
      t.boolean :isRequester, :null=>false, :default=>true

      t.timestamps
    end
  end
end
