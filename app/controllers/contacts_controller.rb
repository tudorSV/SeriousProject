class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    # binding.pry
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      flash[:success] = 'The message has been created!'
      AppointmentMailer.message_creation_confirmation_email(@contact).deliver_now
      redirect_to root_url
    else
      flash.now[:danger] = "The message couldn't be created!"
      render 'new'
    end
  end

  def index
  end

  def show
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number, :message, :user_id)
  end
end
