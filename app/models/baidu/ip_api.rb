class Baidu::IpApi
  include HTTParty
  base_uri 'http://api.map.baidu.com'

  def self.version_url(url)
    "#{url}"
  end

  def self.common_options
    { ak: Rails.application.secrets.baidu['apikey'], 
      # coor不出现时，默认为百度墨卡托坐标；coor=bd09ll时，返回为百度经纬度坐标
      coor: 'bd09ll' }
  end

  # 正确的情况下，返回baidu city_code
  # 错误的情况下，返回nil
  def self.find_city_by_ip(ip)
    begin
      return nil unless ip.present?
      _options = {query: common_options.merge({ip: ip})}
      response = self.get(version_url('/location/ip'), _options)
      if response.code == 200
        result = ActiveSupport::JSON.decode(response.body)
        if result['status'] == 0
          return result['content']['address_detail']['city']
        else
          ＃其他错误的情况
        end
      end
    rescue
      return nil
    end
  end
end
