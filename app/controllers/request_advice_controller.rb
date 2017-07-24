class RequestAdviceController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first before requesting an advice"
      redirect_to(login_index_path)
      return
    end

    # Match user with a question to be answered.
    # Not the question asked by the user themself
    matchRequest = Request.where(:answerUserId => nil).where.not(:askUserId=>currentUser.id).limit(50).sample

    if matchRequest.nil?
      return
    end

    matchUser = User.find_by(:id => matchRequest[:askUserId])

    # Setup instance variables for view
    @matchUserName = matchUser.nickName
    @matchUserId = matchUser.id
    @matchRequestId = matchRequest.id

    @matchReqeustTitle = matchRequest.title
    @matchReqeustDetails = matchRequest.details
    @matchRequestAskTime = matchRequest.askTime.strftime("%B %d, %Y")

  end

  def onSubmitQuestion

    if currentUser.nil?
      flash[:notice] = "Please log in first before requesting an advice"
      redirect_to(login_index_path)
      return
    end

    requestQuestion = params["request_question"]
    requestAdvice = params["request_advice"]
    @matchUserName = params["matchUserName"]
    matchUserId = params["matchUserId"]
    matchRequestId = params["matchRequestId"]

    @questionTitle = requestQuestion["title"]
    @questionDetails = requestQuestion["details"]
    @questionIsPublic = requestQuestion["isPublic"]

    @adviceAnswer = requestAdvice["answer"]
    if @adviceAnswer.nil?
      redirect_back(fallback_location: request_advice_index_path)
      return
    end

    @questionIsPublicString = "Private Question. No one other than matched users can see this request."
    if @questionIsPublic == 1
      @questionIsPublicString = "Public Question. Is viewable by anyone."
    end

    # Creating a new request for the current user
    newRequest = Request.new
    newRequest.title = @questionTitle
    newRequest.details = @questionDetails
    newRequest.isPublic = @questionIsPublic
    newRequest.askTime = Time.now
    newRequest.askUserId = currentUser.id

    saveSuccess = true
    if !newRequest.save
      saveSuccess = false
    end

    # Adding current user's advice to the matched user's request
    matchRequest = Request.find_by(:id => matchRequestId)
    if !matchRequest.nil?
      matchRequest.answer = @adviceAnswer
      matchRequest.answerTime = Time.now
      matchRequest.answerUserId = currentUser.id

      if !matchRequest.save
        saveSuccess = false
      end
      
    end

    if saveSuccess
      flash[:notice] = "Saved Successfully"
    else
      flash[:notice] = "Error Saving: #{newRequest.errors.full_messages}"
    end
  end


end
