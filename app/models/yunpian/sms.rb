class Yunpian::Sms
  include HTTParty
  base_uri 'http://yunpian.com'

  def self.version_url(url)
    "/v1#{url}"
  end

  def self.common_options
    { apikey: Rails.application.secrets.yunpian['apikey'] }
  end

  def self.send_register_captcha(mobile, params)
    _tpl_values = {}
    params.each { |k, v| _tpl_values["##{k}#"] = v }
    _options = common_options.merge({
      mobile: mobile,
      tpl_id: 1,
      tpl_value: _tpl_values.to_param
    })
    self.post(version_url('/sms/tpl_send.json'), {body: _options})
  end
end
