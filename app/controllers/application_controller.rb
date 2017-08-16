class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # include among all actions
  helper :Application

  include LoginHelper

  before_action :setInstanceVariables

  def setInstanceVariables
    @loginLabelText = "Log in"
    @loginLabelPath = login_index_path
    unless currentUser.nil?
      @loginLabelText = "Log out"
      @loginLabelPath = logout_path
    end
  end

end
