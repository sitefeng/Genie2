module RequestDetailsHelper

  def getAskUserNickNameForRequest(req)
    askUserName = User.find_by(:id => req.askUserId).nickName
    return askUserName
  end

  def getAnswerUserNickNameForRequest(req)
    askUser = User.find_by(:id => req.answerUserId)
    if askUser.nil?
      return nil
    end
    return askUser.nickName
  end


  def getFavoriteCountForRequest(req)
    favVotes = FavoriteVote.where(:votable_id => req.id)
    favCount = 0
    if favVotes.nil?
      favCount = 0
    else
      favCount = favVotes.count
    end
    return favCount
  end

  def getIsFavoriteForRequest(req)
    isFav = false
    if currentUser.nil?
      isFav = false
    else
      favVote = FavoriteVote.find_by(:user_id => currentUser.id, :votable_id => req.id)
      if favVote.nil?
        isFav = false
      else
        isFav = true
      end
    end
    return isFav
  end

  def getIsStarForRequest(req)
    isStar = false
    if currentUser.nil?
      isStar = false
    else
      starVote = StarVote.find_by(:user_id => currentUser.id, :votable_id => req.id)
      if starVote.nil?
        isStar = false
      else
        isStar = true
      end
    end
    return isStar
  end

  def getCommentCountForRequest(req)
    commentCount = Comment.where(:request => req).length
    return commentCount
  end
  
end
