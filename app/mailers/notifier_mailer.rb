class NotifierMailer < ActionMailer::Base
  default from: 'example@email.com'
  def sample_email(user)
    @user = user
    # binding.pry
    mail(to: @user.email, subject: 'Sample Email')
  end
end
