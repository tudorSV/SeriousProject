class AppointmentsController < ApplicationController
  # load_and_authorize_resource :user
  # load_and_authorize_resource :appointment, through: :user
  # load_and_authorize_resource :shop

  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
    @shops = Shop.pluck(:name, :id)
  end

  def create
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:appointment][:shop_id])
    @appointment = Appointment.new(appointments_params.merge(user_id: @user.id,
                                                             shop_id: @shop.id))
    if @appointment.save
      flash[:success] = 'The appointment has been added'
      redirect_to user_path(@user)
    else
      flash[:danger] = "The appointment couldnt'be created!"
      render 'new'
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def index
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    @user = User.find(params[:user_id])
    if @appointment.update(appointments_params)
      flash[:success] = 'The appointment has been updated!'
      return redirect_to user_appointment_path(@user, @appointment)
    else
      flash[:failure] = "The appointment couldn't be updated!"
      render 'edit'
    end
  end

  private

  def appointments_params
    params.require(:appointment).permit(:date, :item_number)
  end
end
