class FrontController < ApplicationController
  layout "front"
  before_action :set_current_city
  before_action :set_catagory_nav

  helper_method :current_open_city

  # GET /sign_in_status.json
  # 得到当前是否登录，适用于AJAX请求
  def sign_in_status
    if current_user
      render text: 'true', status: :ok
    else
      render text: 'false', status: :ok
    end
  end

private
  def set_catagory_nav
    @catagories = Catagory.all
  end

  # 子域名是否有效，必须是已经开通的城市的拼音
  def subdomain_ok?
    request.subdomain.present? && request.subdomain != 'www' &&
      request.subdomains.size == 1 && OpenCity.is_valid_subdomain?(request.subdomain)
  end

  # 默认的城市定位
  def default_current_city
    # IP查找城市
    if Rails.env.development?
      # 郑州市IP
      city_name = Baidu::IpApi.find_city_by_ip('218.28.191.23')
    else
      city_name = Baidu::IpApi.find_city_by_ip(request.remote_ip)
    end

    if city_name.present?
      OpenCity.where("name like ?", "%#{city_name.gsub('市', '')}%").first || 
        OpenCity.find(Car::Constants::DEFAULT_OPEN_CITY_ID)
    else
      # 默认城市，ID为1的城市，目前是西安
      OpenCity.find(Car::Constants::DEFAULT_OPEN_CITY_ID)
    end
  end

  # 当前城市
  def current_open_city
    @current_open_city || OpenCity.find_by_short_name(request.subdomain) || 
      default_current_city
  end

  # 设置城市或者切换城市
  def set_current_city
    if subdomain_ok?
      @current_open_city = OpenCity.find_by_short_name(request.subdomain)
      cookies[:current_city] = {value: @current_open_city.id, :expires => 1.year.from_now,
        domain: Rails.env.development? ? 'car.me' : 'xiansc.cn'}
    else
      _open_city = OpenCity.find_by_id(cookies[:current_city])
      if _open_city.nil?
        _open_city = default_current_city
      end
      @current_open_city = _open_city
      redirect_to root_url(subdomain: _open_city.short_name)
    end
  end

end
