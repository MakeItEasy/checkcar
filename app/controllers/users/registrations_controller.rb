class Users::RegistrationsController < Devise::RegistrationsController
  # def new
  #   super
  # end

  def create
    if params[:captcha].present? && valid_captcha?(params[:captcha])
      create_in_devise
    else
      self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_up)
      self.resource.valid?
      clean_up_passwords(resource)
      if params[:captcha].present?
        flash.now[:recaptcha_error] = "验证码错误"      
      else
        flash.now[:recaptcha_error] = "不能为空字符"
      end
      render :new
    end
  end

protected
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

private
  def create_in_devise
    build_resource(sign_up_params)

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
end
