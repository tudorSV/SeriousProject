class UsersController < ApplicationController
  load_and_authorize_resource

  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
      @address = Address.new
      @address = @user.build_address
    end
  end

  def create
    @user = User.new(user_params.merge(address_params))
    if @user.save
      flash[:success] = 'The user has been created!'
      redirect_to login_path
    else
      flash[:danger] = "The user couldn't be updated!"
      render 'new'
    end
  end

  def show
  end

  def edit
    @user = User.find_by(id: params[:id])
    return redirect_to users_path if @user.blank?
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params.merge(address_params))
      flash[:success] = 'The user has been updated!'
      redirect_to user_path(@user)
    else
      flash[:danger] = "The user couldn't be created!"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'The user has been deleted!'
    redirect_to users_path
  end

  def index
    @user = User.all
  end

  def recoverPassword
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :admin, :password, :password_confirmation)
  end

  def address_params
    params.require(:user).permit(address_attributes: [:short_address, :full_address, :city, :zipcode, :country])
  end
end
