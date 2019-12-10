class ApplicationMailer < ActionMailer::Base
  default from: 'testrorblog@gmail.com', subject: 'Welcome to My Awesome Site'
  layout 'mailer'
end
