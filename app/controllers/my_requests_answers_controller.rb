class MyRequestsAnswersController < ApplicationController

  include ActivityHelper

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
      redirect_to(login_index_path)
      return
    end

    currentUserId = currentUser.id

    @requests = Request.where(:answerUserId => currentUserId).order(:answerTime => :desc)

    @askUserNames = Array.new()
    @favCountArray = Array.new()
    @isFavArray = Array.new()
    @isStarArray = Array.new()
    @commentCountArray = Array.new()
    @requests.each do |req|
      @askUserNames.push(getAskUserNickNameForRequest(req))
      @favCountArray.push(getFavoriteCountForRequest(req))
      @isFavArray.push(getIsFavoriteForRequest(req))
      @isStarArray.push(getIsStarForRequest(req))
      @commentCountArray.push(getCommentCountForRequest(req))
    end

  end

end
