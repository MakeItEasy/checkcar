require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Checkcar
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = 'zh-CN'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]

    # 加载自定义simple_navigation的render
    config.autoload_paths << "#{config.root}/app/navigation_renders" 
    config.autoload_paths << "#{config.root}/lib" 

    # 默认不生成assets
    config.generators.assets = false

    # 163邮件配置
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.163.com',
      port:                 25,
      domain:               'www.163.com',
      user_name:            Rails.application.secrets.mail["user_name"],
      password:             Rails.application.secrets.mail["password"],
      authentication:       'login'
    }

    # devise layout设置
=begin
    config.to_prepare do
      Devise::Mailer.layout "devise_email"
    end
=end
  end
end
