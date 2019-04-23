class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user
  end

  def create
    user = User.find_by_username(params[:username]) if params[:username]
    if user && user.authenticate(params[:password]) && user.active && !user.blocked
      session[:user_id] = user.id
      flash[:success] = 'The user logged in!'
      redirect_to users_path
    else
      if user && !user.active
        flash[:danger] = 'The user is inactive! Please contact the administrator'
      elsif user && user.blocked
        flash[:danger] = 'The user is blocked!'
      else
        flash[:danger] = 'The username/password is incorrect!'
      end
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
