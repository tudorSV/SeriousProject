class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
     render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
   end
end
