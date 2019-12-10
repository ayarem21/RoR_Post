class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(author)
    @author = author
    mail(to: @author.email, subject: 'Welcome to My Awesome Site')
  end

end
