class StarVote < ApplicationRecord

  # associations
  belongs_to :votable, :polymorphic=>true
  belongs_to :user

end
