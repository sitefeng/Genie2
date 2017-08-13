class MyRequestsAnswersController < ApplicationController
  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
      redirect_to(login_index_path)
      return
    end

    currentUserId = currentUser.id

    @requests = Request.where(:answerUserId => currentUserId).order(:answerTime => :desc)

    @askUserNames = []
    for req in @requests
      askUserName = User.find_by(:id=>req.askUserId).nickName
      @askUserNames.push(askUserName)
    end

  end

end
