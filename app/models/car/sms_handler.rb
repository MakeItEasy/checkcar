class Car::SmsHandler

  TEMPLATES = { "449197" => "发送手机动态码" }

  # 发送手机动态码
  def self.send_phone_authcode(telephone, code)
    template_id = "449197"
    sms = SmsService.new({telephone: telephone, template_id: template_id, description: TEMPLATES[template_id]})
    sms.options = {code: code, hour: "半"}
    sms.save
  end
end
