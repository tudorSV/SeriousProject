class AppointmentMailer < ActionMailer::Base
  def user_appointment_confirmation_email(appointment)
    @appointment = appointment
    mail(from: "contact@chinesebikes.com", to: @appointment.user.email, subject: "Your appointment on shop #{@appointment.shop.name} has been confirmed!")
  end

  def shop_appointment_confirmation_email(appointment)
    @appointment = appointment
    mail(from: "contact@chinesebikes.com", to: @appointment.shop.email, subject: "Appointment on #{@appointment.date}, belonging to #{@appointment.user.name} has been confirmed.")
  end

  def change_appointment_status_email(appointment)
    @appointment = appointment
    mail(from: "contact@chinesebikes.com", to: @appointment.user.email, subject: "The date of the appointment on shop #{@appointment.shop.name} has been changed to #{@appointment.date}.")
  end

  def user_thank_you_email(appointment)
    @appointment = appointment
    mail(from: "contact@chinesebikes.com", to: @appointment.user.email, subject: "Thank you for using the services of #{@appointment.shop.name}")
  end
end
