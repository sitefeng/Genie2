class CreateFavoriteVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_votes do |t|

      t.belongs_to :user, :foreign_key=>true, :index=>true
      t.belongs_to :votable, :polymorphic=>true, :index=>true

      t.timestamps
    end
  end
end
