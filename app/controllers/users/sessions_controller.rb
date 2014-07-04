class Users::SessionsController < Devise::SessionsController
  # def new
  #   super
  # end

  def create
    if valid_captcha?(params[:captcha])
      super
    else
      # build_resource(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
      self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
      clean_up_passwords(resource)
      flash[:alert] = "验证码错误"      
      flash.delete :recaptcha_error
      render :new
    end
  end


  # 手机动态验证码登录
  def new_by_telephone
    self.resource = User.new
  end

  # 手机动态验证码登录
  def create_by_telephone
    self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_in_by_telephone)
    if error = param_check_for_telephone
      flash[:alert] = error
      render :new_by_telephone
    else
      user = User.find_by(telephone: self.resource.telephone)
      sign_in user
      session[:phone_authcode] = nil
      session[:phone_authcode_send_time] = nil
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

private

  def is_flashing_format?
    false
  end

  ## 手机动态登录的参数验证,返回错误信息
  def param_check_for_telephone
    return "验证码错误" if !valid_captcha?(params[:captcha])
    return "请输入手机号码" if self.resource.telephone.blank?
    return "请输入手机动态码" if params[:phone_authcode].blank?
    return "该手机号码未注册" if User.find_by(telephone: self.resource.telephone).nil?
    return "手机动态码错误" if session[:phone_authcode] != params[:phone_authcode]
    return "手机动态码已经过期，请重新获取" if Time.now - session[:phone_authcode_send_time].to_time > 30*60
  end
end
