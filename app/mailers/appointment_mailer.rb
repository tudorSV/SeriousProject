class AppointmentMailer < ActionMailer::Base
  default from: 'example@email.com'

  def user_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Appointment created')
  end

  def shop_email(appointment)
    @appointment = appointment
    mail(to: @appointment.shop.email, subject: 'Appointment created')
  end

  def status_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Appointment update')
  end

  def thank_you_email(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Appointment has been completed')
  end
end
