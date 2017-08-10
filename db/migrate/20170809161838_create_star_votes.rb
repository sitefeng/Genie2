class CreateStarVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :star_votes do |t|

      t.belongs_to :user, :foreign_key=>true, :index=>true
      t.belongs_to :request, :foreign_key=>true, :index=>true

      t.timestamps
    end
  end
end
