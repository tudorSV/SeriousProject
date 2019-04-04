class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
  end

  def create
    @user = User.find(params[:appointment][:user_id])
    @appointment = Appointment.new(appointments_params.merge(shop_id: @shop.id))

    if @appointment.save
      flash[:success] = 'The appointment has been added'
      # redirect_to user_appointments_path(@user)
    else
      render[:danger] = "The appointment couldnt'be created!"
      render 'new'
    end
  end

  private

  def appointments_params
    params.require(:appointment).permit(:date, :item_number, :status, :user_id)
  end
end
