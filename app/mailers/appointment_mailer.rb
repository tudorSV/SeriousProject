class AppointmentMailer < ActionMailer::Base
  default from: 'example@email.com'

  def user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Appointment created')
  end

  def shop_email(appointment)
    @shop = appointment
    mail(to: @shop, subject: 'Appointment created')
  end

  def status_email(appointment)
    @user = appointment
    mail(to: @user.email, subject: 'Appointment update')
  end

  def thank_you_email(appointment)
    @user = appointment
    mail(to: @user.email, subject: 'Appointment has been completed')
  end
end
