class LoginController < ApplicationController
  def index
  end

  def onLogin

    userLogin = params["user_login"]

    if userLogin['username'].length < 6 ||
       userLogin['username'].length > 20 ||
       userLogin['password'].length < 6 ||
       userLogin['password'].length > 20
       flash[:notice] = "Login Failed: Please enter valid username and password"
       redirect_back(fallback_location: login_index_path)
       return
     end

    user = User.find_by(:username => userLogin['username'])

    passwordValid = user.storedPasswordHashMatchesPassword(userLogin['password'], user.salt)

    if passwordValid
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

    dupUser1 = User.find_by(:username => userSignup["username"])
    dupUser2 = User.find_by(:email => userSignup["email"])

    if dupUser1 != nil || dupUser2 != nil
      flash[:notice] = "Error Registering: User with the same username or email already exists"
      redirect_back(fallback_location: login_index_path)
      return
    end

    newUser = User.new
    newUser.username = userSignup["username"]
    newUser.password = userSignup["password"]
    newUser.password_confirmation = userSignup["password_confirmation"]
    newUser.email = userSignup["email"]
    newUser.nickName = userSignup["nick_name"]
    newUser.emailNotifications = userSignup["email_notifications"]

    if newUser.save
      flash[:notice] = "Registration Success"
    else
      flash[:notice] = "Error Registering: #{newUser.errors.full_messages}"
      redirect_back(fallback_location: login_index_path)
      return
    end

  end

end
