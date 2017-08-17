class RequestDetailsController < ApplicationController

  include RequestDetailsHelper

  def index
    reqId = params[:id]
    @req = Request.find_by(:id => reqId)
    @askUserName = getAskUserNickNameForRequest(@req)
    @answerUser = getAnswerUserNickNameForRequest(@req)

    @favCount = getFavoriteCountForRequest(@req)
    @isFav = getIsFavoriteForRequest(@req)
    @isStar = getIsStarForRequest(@req)
    @commentCount = getCommentCountForRequest(@req)

    @comments = Comment.where(:request => @req).order(:created_at => :desc).limit(300)

  end

  def onCreateComment

    rawComment = params["comment"]
    requestId = params['request_id']

    if currentUser.nil?
      flash['notice'] = "Please log in first to comment"
      redirect_to login_index_path
      return
    end

    @newComment = Comment.new()
    @newComment.content = rawComment['content'].truncate(500, separator: ' ')
    @newComment.user = currentUser

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
