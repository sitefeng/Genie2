class RequestDetailsController < ApplicationController
  def index
    reqId = params[:id]
    @req = Request.find_by(:id => reqId)
    @askUser = User.find_by(:id => @req.askUserId)
    @answerUser = User.find_by(:id => @req.answerUserId)

    @favCount = 0
    favs = FavoriteVote.where(:votable => @req)
    unless favs.nil?
      @favCount = favs.length
    end

    @isFav = false
    currentUserFavoritedOrNil = FavoriteVote.find_by(:user => currentUser)
    unless currentUserFavoritedOrNil.nil?
      @isFav = true
    end

    @isStar = false
    currentUserStarredOrNil = StarVote.find_by(:user => currentUser)
    unless currentUserStarredOrNil.nil?
      @isStar = true
    end

    @comments = Comment.where(:request => @req).order(:created_at => :desc).limit(300)

  end

  def onCreateComment

    if currentUser.nil?
      flash['notice'] = "Please log in first to comment"
      return
    end

    rawComment = params["comment"]

    @newComment = Comment.new()
    @newComment.content = rawComment['content'].truncate(500, separator: ' ')
    @newComment.user = currentUser

    requestId = params['request_id']
    newCommentRequest = Request.find_by(:id => requestId)
    @newComment.request = newCommentRequest

    if !@newComment.save
      flash['notice'] = "Cannot comment at this time. Please try again later."
      return
    end

    respond_to do |format|
      format.html {redirect_to request_details_path(requestId)}
      format.js
    end

  end

end
