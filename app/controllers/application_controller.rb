class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  def require_correct_user
    user = User.find(current_user.id)
    redirect_to "/bright_ideas" if current_user != user
  end
  def require_login
    redirect_to '/' if session[:user_id] == nil
  end
  helper_method :current_user
end
