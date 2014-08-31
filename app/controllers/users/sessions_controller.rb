class Users::SessionsController < Devise::SessionsController
  # def new
  #   super
  # end

  def create
    if valid_captcha?(params[:captcha])
      # super
      self.resource = warden.authenticate!(auth_options)
      if self.resource
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_to do |format|
          format.html { respond_with resource, location: after_sign_in_path_for(resource) }
          format.json { render json: {}, status: :ok }
        end
      else
        self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
        clean_up_passwords(resource)
        respond_to do |format|
          format.html do
            render :new
          end
          format.json do
            render json: {error: I18n.t('devise.failure.invalid')}, status: :unprocessable_entity
          end
        end
      end
    else
      # build_resource(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
      self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
      clean_up_passwords(resource)
      respond_to do |format|
        format.html do
          flash[:alert] = I18n.t('view.alert.captcha_error')
          render :new
        end
        format.json { render json: {error: I18n.t('view.alert.captcha_error')}, status: :unprocessable_entity }
      end
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
      respond_to do |format|
        format.html do
          flash[:alert] = error
          render :new_by_telephone
        end
        format.json { render json: {error: error}, status: :unprocessable_entity}
      end
    else
      user = User.find_by(telephone: self.resource.telephone)
      # 动态登录后要把错误尝试数改掉
      user.unlock_access!
      sign_in user
      session[:phone_authcode] = nil
      session[:phone_authcode_send_time] = nil
      respond_to do |format|
        format.html { respond_with resource, location: after_sign_in_path_for(resource) }
        format.json { render json: {}, status: :ok }
      end
    end
  end

private

  ## 手机动态登录的参数验证,返回错误信息
  def param_check_for_telephone
    return "验证码错误" if !valid_captcha?(params[:captcha])
    return "请输入手机号码" if self.resource.telephone.blank?
    return "请输入手机动态码" if params[:phone_authcode].blank?
    return "该手机号码未注册" if User.find_by(telephone: self.resource.telephone).nil?
    return "手机动态码错误" if session[:phone_authcode] != params[:phone_authcode]
    return "手机动态码已经过期，请重新获取" if Time.now - session[:phone_authcode_send_time].to_time > Car::Constants::PHONE_AUTHCODE_EXPIRES
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    # request.referrer == request.original_url ? root_path : request.referrer
    front_user_root_path
  end
end
