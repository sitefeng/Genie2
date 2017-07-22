class UserPost < ApplicationRecord
  validates_presence_of :userId
  validates_presence_of :questionId
  validates_presence_of :isRequester
end
