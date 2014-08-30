class SmsHandler
  TEMPLATES = { "449197" => "发送手机动态码" }
  def self.send_register_captcha(telephone, code)
    template_id = "449197"
    sms = SmsService.new({telephone: telephone, template_id: template_id, description: TEMPLATES[template_id]})
    sms.options = {code: code, hour: "半"}
    sms.save
  end
end
