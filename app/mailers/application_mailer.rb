class ApplicationMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAILER"]
  layout "mailer"
end
