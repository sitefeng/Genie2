class MyRequestsFavoritedController < ApplicationController

  include RequestDetailsHelper

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Requests"
      redirect_to(login_index_path)
      return
    end

    @favoritedVotes = FavoriteVote.where(:user => currentUser, :votable_type=>:Request).order(:updated_at => :desc)

    @favoritedRequests = Array.new()
    for favVote in @favoritedVotes
      requestForVote = favVote.votable
      @favoritedRequests.push(requestForVote)
    end

    if @favoritedRequests.nil?
      @favoritedRequests = Array.new()
    end

    @askUserNames = Array.new()
    @favCountArray = Array.new()
    @isFavArray = Array.new()
    @isStarArray = Array.new()
    @commentCountArray = Array.new()
    @favoritedRequests.each do |req|
      @askUserNames.push(getAskUserNickNameForRequest(req))
      @favCountArray.push(getFavoriteCountForRequest(req))
      @isFavArray.push(getIsFavoriteForRequest(req))
      @isStarArray.push(getIsStarForRequest(req))
      @commentCountArray.push(getCommentCountForRequest(req))
    end
  end


  def create
    if currentUser.nil?
      flash[:notice] = "Please log in first to favorite a request"
      redirect_to(login_index_path)
      return
    end

    requestId = params[:request_id]
    request = Request.find_by(:id=> requestId)

    if request.nil?
      flash[:notice] = "Request cannot be found this time, please try again later"
      return
    end

    # Check if the user has already favorited this request
    favoriteVoteOrNil = FavoriteVote.find_by(:user_id => currentUser.id, :votable_id => requestId)

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
