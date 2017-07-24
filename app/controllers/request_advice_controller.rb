class RequestAdviceController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first before requesting an advice"
      redirect_to(login_index_path)
      return
    end
  end

  def onSubmitQuestion
    @requestQuestion = params["request_question"]
    @requestAdvice = params["request_advice"]

    @questionTitle = @requestQuestion["title"]
    @questionDetails = @requestQuestion["details"]
    @questionIsPublic = @requestQuestion["isPublic"]

    @adviceAnswer = @requestAdvice["answer"]

    newRequest = Request.new
    newRequest.title = @questionTitle
    newRequest.details = @questionDetails
    newRequest.isPublic = @questionIsPublic
    newRequest.askTime = Time.now
    newRequest.askUserId = currentUser.id

    @saveResultString = "Request Not Saved"
    if newRequest.save
      @saveResultString = "Saved Successfully"
    else
      @saveResultString = "Error Saving: #{newRequest.errors.full_messages}"
    end

  end

  private
  def createNewRequest
  end

  private
  def addAdviceToRequest

  end


end
