class ApplicationMailer < ActionMailer::Base
  default from: ActionMailer::Base.email_address_with_name(
    ENV["SMTP_SENDER_EMAIL"], ENV["SMTP_SENDER_NAME"]
  )
  layout "mailer"
end
