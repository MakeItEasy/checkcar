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

  def subdomain_ok?
    request.subdomain.present? && request.subdomain != 'www' &&
      request.subdomains.size == 1 && OpenCity.is_valid_subdomain?(request.subdomain)
  end

  def default_current_city
    # TODO dairg IP查找
    # TODO dairg default current city
    OpenCity.find(1)
  end

  def current_open_city
    @current_open_city || OpenCity.find_by_short_name(request.subdomain) || 
      default_current_city
  end


  def set_current_city
    puts "====================="
    puts cookies[:current_city]
    # cookies.delete :current_city
    if subdomain_ok?
      puts "11111111111111111111"
      cookies[:current_city] = {value: request.subdomain, domain: 'car.me'}
      @current_open_city = OpenCity.find_by_short_name(request.subdomain)
    else
      puts "2222222222222222222222"
      _open_city = OpenCity.find_by_short_name(cookies[:current_city])
      if _open_city.nil?
        puts "333333333333333333333333"
        _open_city = default_current_city
      end
      @current_open_city = _open_city
      redirect_to root_url(subdomain: _open_city.short_name)
    end
  end

end
