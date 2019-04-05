class AppointmentsController < ApplicationController
    load_and_authorize_resource :user
    load_and_authorize_resource :appointment, through: :user

  def new
    @appointment = Appointment.new
  end

  def create
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:appointment][:shop_id])
    @appointment = Appointment.new(appointments_params.merge(user_id: @user.id, shop_id: @shop.id))
    if @appointment.save
      flash[:success] = 'The appointment has been added'
      redirect_to user_appointment_path(@user, @appointment)
    else
      flash[:danger] = "The appointment couldnt'be created!"
      render 'new'
    end
  end

  def show
  end

  def index
  end

  private

  def appointments_params
    params.require(:appointment).permit(:date, :item_number, :status, :user_id, :shop_id)
  end
end
