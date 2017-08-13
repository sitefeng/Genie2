class MyRequestsQuestionsController < ApplicationController

  def index

    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Requests"
      redirect_to(login_index_path)
      return
    end

    currentUserId = currentUser.id

    @requests = Request.where(:askUserId => currentUserId).order(:askTime => :desc)

    currentUser = User.find_by(:id => currentUserId)
    @currentUserName = currentUser.nickName

  end
  
end
