# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.site_key = "6LcTR3cUAAAAAEuKg4upaV3oJrDudqiT15mhSVOL"
    config.secret_key = "6LcTR3cUAAAAABHWMNfkxe89cmdxLFnUOC2yaUy_"
  else # production / staging
    config.site_key  = Rails.application.credentials.dig(:recaptcha, :site_key)
    config.secret_key = Rails.application.credentials.dig(:recaptcha, :secret_key)
  end
end
