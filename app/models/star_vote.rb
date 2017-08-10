class StarVote < ApplicationRecord

  # associations
  belongs_to :request
  belongs_to :user

end
