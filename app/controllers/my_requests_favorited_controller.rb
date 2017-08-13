class MyRequestsFavoritedController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
      redirect_to(login_index_path)
      return
    end

    @favoritedRequests = FavoriteVote.find_by(:user => currentUser)

    @askUserNames = Array.new()
    @favoritedRequests.each do |req|
      askUserId = req.askUserId
      askUserName = User.find(askUserId).nickName
      @askUserNames.push(askUserName)
    end
  end


  def create
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
      redirect_to(login_index_path)
      return
    end

    requestId = params[:request_id]
    request = Request.find_by(:id=> requestId)

    if request.nil?
      flash[:notice] = "Request cannot be found this time, please try again later"
      return
    end

    favoriteVoteOrNil = FavoriteVote.find_by(:user => currentUser)

    # Toggle Favorite
    if favoriteVoteOrNil.nil?

      # Create a new vote if request has not been favorited
      favorite = FavoriteVote.new
      favorite.user = currentUser
      favorite.votable = request
      if !favorite.save
        flash[:notice] = "Cannot favorite this item at this time, please try again later"
      end

    else
      # Remove favorite if request has been favorited
      favoriteVoteOrNil.destroy

    end

  end


end
