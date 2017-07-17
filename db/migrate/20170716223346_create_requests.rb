class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :details
      t.boolean :isPublic
      t.datetime :askTime
      t.integer :askUserId
      t.text :answer
      t.datetime :answerTime
      t.integer :answerUserId

      t.timestamps
    end
  end
end
