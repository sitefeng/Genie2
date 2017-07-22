class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :title, :null=>false
      t.text :details
      t.boolean :isPublic, :null=>false
      t.datetime :askTime, :null=>false
      t.integer :askUserId, :null=>false
      t.text :answer
      t.datetime :answerTime
      t.integer :answerUserId

      t.timestamps
    end
  end
end
