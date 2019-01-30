Rails.application.configure do
  if Rails.env.development?
    config.action_mailer.default_url_options = { host: 'localhost:5000' }

    config.action_mailer.delivery_method = :letter_opener
    config.action_mailer.perform_deliveries = true
  elsif Rails.env.production?
    config.action_mailer.default_url_options = { host: 'cyber-dashboard.herokuapp.com' }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.default charset: 'utf-8'

    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      authentication: 'plain',
      enable_starttls_auto: true,
      user_name: ENV['GMAIL_USERNAME'],
      password: ENV['GMAIL_PASSWORD']
    }
  else
    config.action_mailer.default_url_options = { host: 'localhost:5000' }
    config.action_mailer.delivery_method = :test
  end
end
