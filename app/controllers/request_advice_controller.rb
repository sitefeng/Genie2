class RequestAdviceController < ApplicationController

  def index
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
    newRequest.askUserId = 1

    @saveResultString = "Request Not Saved"
    if newRequest.save
      @saveResultString = "Saved Successfully"
    else
      @saveResultString = "Error Saving"
    end


  end

  private
  def createNewRequest
  end

  private
  def addAdviceToRequest

  end


end
