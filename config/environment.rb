# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Appcontraption::Application.initialize!

# ActionMailer delivery method
config.action_mailer.delivery_method = :smtp

# ActionMailer configuration settings
ActionMailer::Base.smtp_settings = {
  :address  => "mail.stonehen.com",
  :port  => 26,
  :user_name  => "info+stonehen.com",
  :password  => "godislove777",
  :authentication  => :login
}

# Raise errors on mail delivery
config.action_mailer.raise_delivery_errors = true

# Set default host
config.action_mailer.default_url_options = {
  :host => "stonehen.com"
}

#try to force sending in development 
#config.action_mailer.perform_deliveries = true

