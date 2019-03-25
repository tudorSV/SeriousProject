class UsersController < ApplicationController

  def new
    @user = User.new
    @address = Address.new()
  end

  def create
    @user = User.new(user_params)
    @address = Address.new(address_params)
    @user.address = @address
    if @user.save
      flash[:success] = "The user has been created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.address.update_attributes(address_params)
    if @user.update_attributes(user_params)
      flash[:success] = "The user has been updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @user.address.destroy
    flash[:success] = "The user has been deleted!"
    redirect_to root_path
  end

  def index
    @user = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end

    def address_params
      params.require(:user).require(:address).permit(:short_address, :full_address, :city, :zipcode, :country)
    end
end
