class SettingsController < ApplicationController

  def index
    if currentUser.nil?
      flash[:notice] = "Please log in first to see Settings"
      redirect_to(login_index_path)
      return
    end

    @username = currentUser.username
    @email = currentUser.email
    @nickName = currentUser.nickName
    @isNotified = currentUser.emailNotifications
    if @isNotified.nil?
      @isNotified = false
    end

    questionRequests = Request.where(:askUserId => currentUser.id)
    @numQuestions = questionRequests.length

    answerRequests = Request.where(:answerUserId => currentUser.id)
    @numAnswers = answerRequests.length

    favoritedRequests = FavoriteVote.where(:user => currentUser)
    @numFavorites = favoritedRequests.length

    starredRequests = StarVote.where(:user => currentUser)
    @numStars = starredRequests.length

    memberSinceDateTime = currentUser.created_at
    @memberSinceString = memberSinceDateTime.strftime("%B %d, %Y")

  end


  def onUserUpdate

    rawUserDict = params['user']
    newNickname = rawUserDict['nickName']
    newEmail = rawUserDict['email']
    newIsNotif = rawUserDict['email_notification']

    if !newNickname.nil? && newNickname != ""

      if newNickname.length >= 25
        flash['notice'] = "Sorry, nickname must be less than 25 characters"
        redirect_back(fallback_location: settings_path)
        return
      end
      currentUser.nickName = newNickname
    end

    if !newEmail.nil? && newEmail != ""
      if newEmail.length >= 100
        flash['notice'] = "Sorry, email must be less than 100 characters"
        redirect_back(fallback_location: settings_path)
        return
      end
      currentUser.email = newEmail
    end

    dupUser = User.find_by(:email => newEmail)

    if dupUser != nil
      flash[:notice] = "Sorry, user with the same email already exists"
      redirect_back(fallback_location: settings_path)
      return
    end

    currentUser.emailNotifications = newIsNotif

    if currentUser.save
      flash['notice'] = "Yes! Your settings have been changed."
    else
      flash['notice'] = "Sorry, there was an error saving due to the following reason: #{currentUser.errors.full_messages}"
    end

    redirect_to settings_path
  end




end
