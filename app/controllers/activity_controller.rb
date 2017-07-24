class ActivityController < ApplicationController

def index
  # show only public posts on activity page
  @publicRequests = Request.where(:isPublic => true).order(:askTime => :desc)

  @askUserNames = Array.new()
  @publicRequests.each do |req|
    askUserId = req.askUserId
    askUserName = User.find(askUserId).nickName
    @askUserNames.push(askUserName)
  end

end



end
