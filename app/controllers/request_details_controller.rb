class RequestDetailsController < ApplicationController
  def index
    reqId = params[:id]
    @req = Request.find_by(:id => reqId)
    @askUser = User.find_by(:id => @req.askUserId)
    @answerUser = User.find_by(:id => @req.answerUserId)

  end
end
