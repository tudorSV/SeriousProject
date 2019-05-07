class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render file: '/public/404.html', status: 404
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: '/public/403.html', status: 403
  end
end
