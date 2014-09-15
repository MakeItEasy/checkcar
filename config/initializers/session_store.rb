# Be sure to restart your server when you modify this file.

# , tld_length: 2
if Rails.env.development?
  Rails.application.config.session_store :cookie_store, key: '_checkcar_session_development', domain: 'car.me'
else
  Rails.application.config.session_store :cookie_store, key: '_checkcar_session', domain: 'xiansc.cn'
end
