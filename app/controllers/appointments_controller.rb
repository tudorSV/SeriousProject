class AppointmentsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :appointment, through: :user

  def new
    @shops = Shop.pluck(:name, :id)
  end

  def create
    @shop = Shop.find(params[:appointment][:shop_id])
    @appointment = Appointment.new(appointment_params.merge(user_id: @user.id,
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
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      flash[:success] = 'The appointment has been updated!'
      # binding.pry
      AppointmentMailer.user_email(@user).deliver_now
      AppointmentMailer.shop_email(@appointment.shop).deliver_now
      return redirect_to user_appointment_path(@user, @appointment)
    else
      flash[:failure] = "The appointment couldn't be updated!"
      render 'edit'
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :item_number, :status)
  end
end
