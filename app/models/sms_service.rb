class SmsService < ActiveRecord::Base

  # TODO dairg production环境下才发送短信
  before_create :send_sms if Rails.env.production?

  def send_success?
    self.api_code == 0
  end

private
  # 发送手机号
  def send_sms
    begin
      res = Yunpian::Sms.send_sms_by_tpl_id(self.template_id, self.telephone, self.options)
      self.response_code = res.code
      if res.parsed_response
        body_data = ActiveSupport::JSON.decode(res.parsed_response)
        self.api_code = body_data["code"]
        self.api_msg = body_data["msg"]
        self.result = body_data
      end
    rescue => e
      self.exception = e
    end
  end
end
