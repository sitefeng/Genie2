module LoginHelper

  def logInSession(userId)
    session[:user_id] = userId
  end

  def logOutSession
    session[:user_id] = nil
    @currentUser = nil
  end

  def currentUser
    @currentUser ||= User.find_by(:id => session[:user_id])
    return @currentUser
  end

end
