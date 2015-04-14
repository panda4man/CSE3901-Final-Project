class ApplicationController < ActionController::Base
  include ApplicationHelper
	include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login
  protected

  def require_login
    unless current_user
      redirect_to login_path, :flash => {alert: "You need to login"}
    end
  end
end
