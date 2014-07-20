class Users::RegistrationsController < Devise::RegistrationsController
  # def new
  #   super
  # end

  def create
    build_resource(sign_up_params)
    if my_valid_captcha? & valid_phone_authcode?
      create_in_devise
    else
      self.resource.valid?
      clean_up_passwords(resource)
      render :new
    end
  end

protected
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

private
  def create_in_devise
    if resource.mode == "telephone"
      resource.login_type = "telephone"
    end
 
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  ## 手机动态码关联check
  def valid_phone_authcode?
    if resource.mode == "telephone"
      if params[:phone_authcode].blank?
        flash.now[:phone_authcode_error] = "请输入手机动态码" 
        return false
      end
      if session[:phone_authcode] != params[:phone_authcode]
        flash.now[:phone_authcode_error] = "手机动态码错误" 
        return false
      end
      if Time.now - session[:phone_authcode_send_time].to_time > Car::Constants::PHONE_AUTHCODE_EXPIRES
        flash.now[:phone_authcode_error] = "手机动态码已经过期，请重新获取"  
        return false
      end
    end
    return true
  end

  ## 验证码关联check
  def my_valid_captcha?
    if params[:captcha].present?
      if !valid_captcha?(params[:captcha])
        flash.now[:recaptcha_error] = "验证码错误"
        return false
      end
    else
      flash.now[:recaptcha_error] = I18n.t("errors.messages.blank")
      return false
    end
    return true
  end
end
