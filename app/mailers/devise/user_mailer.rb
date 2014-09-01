class Devise::UserMailer < Devise::Mailer
  layout 'devise_mail/user'

  # 模版的format text 和html对应参考
  # https://github.com/plataformatec/devise/issues/2341
end
