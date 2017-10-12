class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :authorized?
  helper_method :current_user

  def logged_in?
    !session[:user_id].nil?
  end

  def authenticate!
    if !logged_in?
      @redirect = true
      render "/sessions/new"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorized?(owner)
    current_user == owner
  end

  def authorize!(owner)
    render :file => "#{Rails.root}/public/404.html", :status => 404 unless authorized?(owner)
  end
end
