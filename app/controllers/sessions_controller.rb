class SessionsController < ApplicationController
  def new; end

  def create
    if current_user
      flash[:fail] = "A user is already logged on"
      redirect_to users_path
    else
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      render 'new'
    end
  end
end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
