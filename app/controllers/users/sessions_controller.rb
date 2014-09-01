class Users::SessionsController < Devise::SessionsController
  # 参考http://stackoverflow.com/questions/20875591/actioncontrollerinvalidauthenticitytoken-in-registrationscontrollercreate
  # 解决BUG：选择remember me，然后登录，然后退出浏览器，然后再打开，这个时候默认时登录的，
  # 但是点击退出不行InvalidAuthenticityToken，刷新一下页面就可以了。(admin 没问题)
  skip_before_filter :verify_authenticity_token, :only => :destroy

  # def new
  #   super
  # end

  def create
    # AJAX参考http://natashatherobot.com/devise-rails-sign-in/
    self.resource = resource_class.new(Devise::UserParameterSanitizer.new(User, :user, params).sign_in)
    if error = param_check_for_account
      clean_up_passwords(resource)
      respond_to do |format|
        format.html do
          flash[:alert] = error
          render :new
        end
        format.json { render json: {error: error}, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.html do
          super
        end
        format.json do
          self.resource = warden.authenticate!({:scope=>:user, :recall=>"users/sessions#failure_ajax"})
          sign_in(resource_name, resource)
          render json: {}, status: :ok
        end
      end
    end
  end

  # AJAX登录失败时
  def failure_ajax
    # TODO dairg 将来研究 貌似这里没有用，即使失败也不执行到这里
    return render json: {error: I18n.t('devise.failure.invalid')}, status: :unprocessable_entity
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

  ## 账号登录时参数验证
  def param_check_for_account
    return I18n.t('view.alert.captcha_error') if !valid_captcha?(params[:captcha])
    return "请输入账号" if self.resource.login.blank?
    return "请输入密码" if self.resource.password.blank?
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    # request.referrer == request.original_url ? root_path : request.referrer
    front_user_root_path
  end
end
