class ActivityController < ApplicationController

include ActivityHelper

def index
  # show only public posts on activity page
  @publicRequests = Request.where(:isPublic => true).order(:askTime => :desc).limit(50)

  @askUserNames = Array.new()
  @favCountArray = Array.new()
  @isFavArray = Array.new()
  @isStarArray = Array.new()
  @commentCountArray = Array.new()
  @publicRequests.each do |req|
    @askUserNames.push(getAskUserNickNameForRequest(req))
    @favCountArray.push(getFavoriteCountForRequest(req))
    @isFavArray.push(getIsFavoriteForRequest(req))
    @isStarArray.push(getIsStarForRequest(req))
    @commentCountArray.push(getCommentCountForRequest(req))
  end

end



end
