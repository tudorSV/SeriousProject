class UsersController < ApplicationController
  load_and_authorize_resource

  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
      @address = @user.build_address
    end
  end

  def create
    @user = User.new(user_params.merge(address_params))
    if @user.save
      flash[:success] = 'The user has been created!'
      AppointmentMailer.user_creation_confirmation_email(@user).deliver_now
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
  end

  def recoverPassword
  end

  def index_admin
    @users = User.all
  end

  def change_status
    @user = User.find(params[:user])
    if !@user.active
      @user.update_attribute(:active, true)
      AppointmentMailer.user_activation_email(@user).deliver_now
      flash[:success] = 'The user is now active!'
      redirect_to users_list_path
    end
  end

  def block_user
    @user = User.find(params[:user])
    if !@user.blocked
      @user.update_attribute(:blocked, true)
      AppointmentMailer.user_block_email(@user).deliver_now
      flash[:success] = 'The user has been banned!'
      redirect_to users_list_path
    elsif @user.blocked
      @user.update_attribute(:blocked, false)
      flash[:success] = 'The ban on the user has been lifted!'
      redirect_to users_list_path
    else
      flash[:danger] = "The action couldn't be done"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :admin, :password,
                                 :password_confirmation, :active, :blocked)
  end

  def address_params
    params.require(:user).permit(address_attributes: [:short_address, :full_address, :city, :zipcode, :country])
  end
end
