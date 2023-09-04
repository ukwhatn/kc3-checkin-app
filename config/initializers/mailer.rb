Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    port: ENV['SMTP_PORT'],
    domain: ENV['SMTP_DOMAIN'],
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: 'login',
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = {
    host: ENV['APP_HOST'], port: Rails.env.development? ? ENV['APP_PORT'] : nil ,
    protocol: Rails.env.development? ? 'http' : 'https'
  }
end
