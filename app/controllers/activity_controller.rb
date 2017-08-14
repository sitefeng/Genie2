class ActivityController < ApplicationController

def index
  # show only public posts on activity page
  @publicRequests = Request.where(:isPublic => true).order(:askTime => :desc).limit(50)

  @askUserNames = Array.new()
  @publicRequests.each do |req|
    askUserId = req.askUserId
    askUserName = User.find(askUserId).nickName
    @askUserNames.push(askUserName)
  end

  @isFavArray = Array.new()
  @publicRequests.each do |req|
    if currentUser.nil?
      @isFavArray.push(false)
    else

      favVote = FavoriteVote.find_by(:user_id => currentUser.id, :votable_id => req.id)
      if favVote.nil?
        @isFavArray.push(false)
      else
        @isFavArray.push(true)
      end
    end
  end

  @isStarArray = Array.new()
  @publicRequests.each do |req|
    if currentUser.nil?
      @isFavArray.push(false)
    else
      favVote =  StarVote.find_by(:user_id => currentUser.id)
      if favVote.nil?
        @isStarArray.push(false)
      else
        @isStarArray.push(true)
      end
    end
  end


end



end
