class MyRequestsFavoritedController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
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
