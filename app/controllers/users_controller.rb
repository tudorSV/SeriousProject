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
      flash[:danger] = "The user couldn't be created!"
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
    if current_user.admin? && update_admin_user_params
      flash[:success] = "The user #{@user.name} has been updated!"
      redirect_to user_path(@user)
    elsif @user.update(user_params.merge(address_params))
      flash[:success] = 'The user has been updated!'
      redirect_to user_path(@user)
    else
      flash[:danger] = "The user couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    if @user == current_user
      flash[:danger] = 'You cannot delete yourself!'
      redirect_to user_path(@user)
    else
      @user.destroy
      flash[:success] = 'The user has been deleted!'
      redirect_to users_path
    end
  end

  def index
  end

  def recoverPassword
  end

  def index_admin
    authorize! :block_user, @user
    @users = User.order(created_at: :asc).all
  end

  def change_status
    @user = User.find(params[:user])
    authorize! :change_status, @user
    if !@user.active
      @user.update_attribute(:active, true)
      AppointmentMailer.user_activation_email(@user).deliver_now
      flash[:success] = 'The user is now active!'
      redirect_to users_list_path
    else
      flash[:danger] = 'The user cannot be updated'
    end
  end

  def block_user
    @user = User.find(params[:user])
    authorize! :block_user, @user
    if !@user.blocked
      if @user.update_attribute(:blocked, true)
        AppointmentMailer.user_block_email(@user).deliver_now
        flash[:success] = 'The user has been banned!'
        redirect_to users_list_path
      else
        flash[:danger] = 'The user cannot be updated'
      end
    elsif @user.blocked
      if @user.update_attribute(:blocked, false)
        flash[:success] = 'The ban on the user has been lifted!'
        redirect_to users_list_path
      else
        flash[:danger] = 'The user cannot be updated'
      end
    else
      flash[:danger] = "The action couldn't be done"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation, :admin,
                                 :active, :blocked)
  end

  def update_admin_user_params
    params.require(:user).permit(:name, :username, :email)
    params[:user].each do |key, value|
      if key != "address_attributes"
        @user.update_attribute(key, value)
      end
    end
    params[:user][:address_attributes].each do |key_addr, value_addr|
      @user.address.update_attribute(key_addr, value_addr)
    end
  end

  def address_params
    params.require(:user).permit(address_attributes: [:short_address,
                   :full_address, :city, :zipcode, :country])
  end
end
