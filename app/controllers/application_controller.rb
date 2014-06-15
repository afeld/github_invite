class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end

  def auth_path(query={})
    "/auth/github?#{query.to_query}"
  end

  def authenticate!
    unless logged_in?
      redirect_to auth_path(origin: request.path)
    end
  end
end
