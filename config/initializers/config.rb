# load config options
configatron.configure_from_yaml("#{RAILS_ROOT}/config/settings.yml", :hash => Rails.env)


if configatron.enable_recaptcha
  ENV['RECAPTCHA_PUBLIC_KEY'] = configatron.recaptcha_key
  ENV['RECAPTCHA_PRIVATE_KEY'] = configatron.recaptcha_secret
end