class SmsService < ActiveRecord::Base

  # 发送注册时手机动态码
  def send_register_captcha
    response = Yunpian::Sms.send_register_captcha(self.telephone, {code: '1234'})
  end
end
