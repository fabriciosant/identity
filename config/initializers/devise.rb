# config/initializers/devise.rb
Devise.setup do |config|
  # ==> Configuration for API authentication
  config.navigational_formats = []

   # ==> JWT Configuration
   config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret
    jwt.expiration_time = 30.days.to_i
    jwt.request_formats = { user: [ :json ] }
  end

  # ==> Mailer Configuration
  config.mailer_sender = "nao-responder@seusistema.com"

  # ==> ORM configuration
  require "devise/orm/active_record"

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]

  # ==> Skip session storage (importante para API)
  config.skip_session_storage = [ :http_auth, :params_auth ]

  # ==> Security configuration
  config.stretches = Rails.env.test? ? 1 : 12
  config.pepper = ENV["DEVISE_PEPPER"] || Rails.application.credentials.devise_pepper

  # ==> Password configuration
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Reset password configuration
  config.reset_password_within = 6.hours
end
