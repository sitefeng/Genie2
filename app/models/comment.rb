class Comment < ApplicationRecord

  # associations
  belongs_to :user
  belongs_to :request
  has_many :favorite_votes, :as=>"votable", :dependent=>:destroy

  # validations
  validates :content, :presence=>true

end
