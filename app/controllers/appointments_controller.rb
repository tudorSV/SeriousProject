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
      AppointmentMailer.user_email(@appointment).deliver_now
      AppointmentMailer.shop_email(@appointment).deliver_now
      redirect_to user_path(@user)
    else
      flash[:danger] = "The appointment couldnt'be created!"
      @shops = Shop.pluck(:name, :id)
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
      return redirect_to user_appointment_path(@user, @appointment)
    else
      flash[:failure] = "The appointment couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    if @appointment.status == 'Booked'
      flash[:success] = 'The appointment has been destroyed!'
      @appointment.destroy
      return redirect_to user_path(@user)
    else
      flash[:failure] = "The appointment couldn't be destroyed!"
      render 'show'
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :item_number, :status, :shop_id)
  end
end
