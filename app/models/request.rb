class Request < ApplicationRecord

  # associations
  belongs_to :user, :foreign_key=> "askUserId"

  has_many :comments, :dependent=>:destroy

  has_many :favorite_votes, :as=>"votable", :dependent=>:destroy
  has_many :star_votes, :as=>"votable", :dependent=>:destroy


  # validations
  validates :title,    :presence => true
  validates :askTime,  :presence => true

end
