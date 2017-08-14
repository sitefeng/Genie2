class MyRequestsStarredController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Requests"
      redirect_to(login_index_path)
      return
    end

    @starredVotes = StarVote.where(:user => currentUser, :votable_type=>:Request).order(:updated_at => :desc)

    @starredRequests = Array.new()
    for starVote in @starredVotes
      requestForVote = starVote.votable
      @starredRequests.push(requestForVote)
    end

    if @starredRequests.nil?
      @starredRequests = Array.new()
    end

    @askUserNames = Array.new()
    @starredRequests.each do |req|
      askUserId = req.askUserId
      askUserName = User.find(askUserId).nickName
      @askUserNames.push(askUserName)
    end
  end


  def create
    if currentUser.nil?
      flash[:notice] = "Please log in first to star a request"
      redirect_to(login_index_path)
      return
    end

    requestId = params[:request_id]
    request = Request.find_by(:id=> requestId)

    if request.nil?
      flash[:notice] = "Request cannot be found this time, please try again later"
      return
    end

    # Check if the user has already starred this request
    starVoteOrNil = StarVote.find_by(:user => currentUser, :votable_id => requestId)

    # Toggle Star
    if starVoteOrNil.nil?

      # Create a new vote if request has not been starred
      star = StarVote.new
      star.user = currentUser
      star.votable = request
      if !star.save
        flash[:notice] = "Cannot star this item at this time, please try again later"
      end

    else
      # Remove star db item if request has been starred
      starVoteOrNil.destroy

    end

  end

end
