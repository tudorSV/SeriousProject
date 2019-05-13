class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      flash[:success] = 'The feedback has been received. Thank you!'
      AppointmentMailer.message_creation_confirmation_email(@contact).deliver_now
      AppointmentMailer.feedback_admin_received(@contact).deliver_now
      redirect_to root_url
    else
      flash.now[:danger] = "The message couldn't be created!"
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number, :message, :user_id)
  end
end
