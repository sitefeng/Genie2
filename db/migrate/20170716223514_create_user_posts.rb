class CreateUserPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_posts do |t|
      t.integer :userId
      t.integer :questionId
      t.boolean :isRequester

      t.timestamps
    end
  end
end
