class AppointmentMailer < ActionMailer::Base
  default from: CONFIGURATION['default_sender']

  def user_appointment_confirmation_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email,
         subject: "Your appointment on shop #{@appointment.shop.name} has been confirmed!")
  end

  def shop_appointment_confirmation_email(appointment)
    @appointment = appointment
    mail(to: @appointment.shop.email,
         subject: "Appointment on #{@appointment.date}, belonging to #{@appointment.user.name} has been confirmed.")
  end

  def change_appointment_status_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email,
         subject: "The status of the appointment on shop #{@appointment.shop.name} has been changed to #{@appointment.date}.")
  end

  def user_thank_you_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email,
         subject: "Thank you for using the services of #{@appointment.shop.name}")
  end

  def user_creation_confirmation_email(user)
    @user = user
    mail(to: user, subject: "Bike shop account has been created")
  end

  def user_activation_email(user)
    @user = user
    mail(to: user,
         subject: "User account on Bike Shop has been activated")
  end

  def user_block_email(user)
    @user = user
    mail(to: user,
         subject: "Your account has been blocked")
  end

  def message_creation_confirmation_email(contact)
    @contact = contact
    mail(to: @contact.email,
         subject: "Your message has been received")
  end

  def feedback_admin_received(contact)
    @contact = contact
    mail(to: CONFIGURATION['feedback_email'],
         subject: "A feedback message has been registered")
  end
end
