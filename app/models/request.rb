class Request < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :isPublic
  validates_presence_of :askTime
  belongs_to :user, :foreign_key=> "askUserId"
  
end
