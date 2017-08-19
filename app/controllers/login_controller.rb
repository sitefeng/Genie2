class LoginController < ApplicationController
  def index
  end

  def onLogin

    userLogin = params["user_login"]
    username = userLogin['username']
    password = userLogin['password']

    if username.nil? ||
       password.nil? ||
       username.length < 6 ||
       username.length > 20 ||
       password.length < 6 ||
       password.length > 20
       flash[:notice] = "Login Failed: Please enter valid username and password"
       redirect_back(fallback_location: login_index_path)
       return
     end

    user = User.find_by(:username => userLogin['username'])
    if user.nil?
      flash[:notice] = "Login Failed: User does not exist"
      redirect_back(fallback_location: login_index_path)
      return
    end

    passwordValid = user.storedPasswordHashMatchesPassword(userLogin['password'], user.salt)

    if passwordValid

      # Log in to current session
      logInSession(user.id)

      # Notice and Redirect
      flash[:notice] = "Login Success"
      redirect_to(activity_index_path)
      return
    else
      flash[:notice] = "Login Failed: Password is incorrect"
      redirect_back(fallback_location: login_index_path)
      return
    end
  end

  def onSignup

    userSignup = params["user_signup"]

    username = userSignup['username']
    email = userSignup["email"]
    password = userSignup['password']
    nickname = userSignup["nick_name"]

    if username.nil? ||
       password.nil? ||
       username.length < 6 ||
       username.length > 20 ||
       password.length < 6 ||
       password.length > 20
       flash[:notice] = "Login Failed: Please enter valid username and password between 6 to 20 digits"
       redirect_back(fallback_location: login_index_path)
       return
     end

    if nickname.nil? || nickname == "" || nickname.length >= 25
      flash['notice'] = "Please enter a valid nickname less than 25 characters and not empty"
      redirect_back(fallback_location: login_index_path)
      return
    end

    if email.nil? || email == "" || email.length >= 100
      flash['notice'] = "Please enter a valid email less than 100 characters"
      redirect_back(fallback_location: login_index_path)
      return
    end

    dupUser1 = User.find_by(:username => username)
    dupUser2 = User.find_by(:email => email)

    if dupUser1 != nil || dupUser2 != nil
      flash[:notice] = "Error Registering: User with the same username or email already exists"
      redirect_back(fallback_location: login_index_path)
      return
    end

    if userSignup["password_repeated"] != userSignup["password"]
      flash[:notice] = "Error Registering: given passwords do not match"
      redirect_back(fallback_location: login_index_path)
      return
    end

    newUser = User.new
    newUser.username = username
    newUser.password = password
    newUser.email = email
    newUser.nickName = nickname
    newUser.emailNotifications = true
    # newUser.emailNotifications = userSignup["email_notifications"]

    if newUser.save

      # Log in session after registration
      logInSession(newUser.id)

      flash[:notice] = "Registration Success"
    else
      flash[:notice] = "Error Registering: #{newUser.errors.full_messages}"
      redirect_back(fallback_location: login_index_path)
      return
    end

  end

  def onLogout
    # Log in to current session
    logOutSession

    # Notice and Redirect
    flash[:notice] = "Logout Success"
    redirect_to(activity_index_path)
    return
  end


end
