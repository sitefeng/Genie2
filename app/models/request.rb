class Request < ApplicationRecord

  validates :title,    :presence => true
  validates :askTime,  :presence => true
  belongs_to :user, :foreign_key=> "askUserId"

end
