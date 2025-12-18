# Handling email functionalities for the application
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
