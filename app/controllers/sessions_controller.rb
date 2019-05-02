class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user
  end

  def create
    user = User.find_by_username(params[:username]) if params[:username]
    if user && user.authenticate(params[:password]) && user.active && !user.blocked
      session[:user_id] = user.id
      flash[:success] = 'The user logged in!'
      return redirect_to users_path
    elsif user && !user.active
      flash[:danger] = 'The user is inactive! Please contact the administrator'
    elsif params[:username] == ''
      flash[:danger] = 'Username is blank'
    elsif params[:password] == ''
      flash[:danger] = 'Password is blank'
    elsif user && user.blocked
      flash[:danger] = 'The user is blocked!'
    else
      flash[:danger] = 'The username/password is incorrect!'
    end
    redirect_to new_session_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
