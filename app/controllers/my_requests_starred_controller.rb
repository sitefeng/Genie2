class MyRequestsStarredController < ApplicationController
  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see My Answers"
      redirect_to(login_index_path)
      return
    end
  end
  
end
