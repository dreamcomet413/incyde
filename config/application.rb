require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

EMAIL_FROM = "no-contestar@viverosincyde.com"

module Incyde
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += ["#{config.root}/lib"]
    config.autoload_once_paths += ["#{config.root}/lib"]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Madrid'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation cannot be found).
    config.i18n.fallbacks = true


    config.action_mailer.smtp_settings = {
        :address => "smtp.viverosincyde.com" ,
        :port => 587,
        :domain => "viverosincyde.com" ,
        :authentication => :login,
        :user_name => EMAIL_FROM,
        :password  => "Alfonso77",
        :enable_starttls_auto => true,
        :openssl_verify_mode  => 'none'
    }

  end
end


ADMIN_MENU_AUX = "Auxiliares"
ADMIN_MENU_USERS = "Usuarios"
WP_URL = 'http://redviveros.incyde.org/'
