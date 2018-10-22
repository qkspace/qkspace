# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = Rails.application.secrets.recaptcha_qkspace_site_key
  config.secret_key = Rails.application.secrets.recaptcha_qkspace_secret_key
end
