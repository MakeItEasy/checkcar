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


  def new_by_telephone
    self.resource = User.new
  end

  def create_by_telephone
    # 手机动态验证码登录
    # TODO dairg 手机动态验证码登录
    
  end

private

  def is_flashing_format?
    false
  end

end
