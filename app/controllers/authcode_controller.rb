### 手机动态验证码
class AuthcodeController < ActionController::Base

  # POST /phone_autucode
  # POST /admins.json
  def phone_authcode
    phone = params[:phone]
    captcha = params[:captcha]
    mode = params[:mode]
    errors = {}
    if phone.blank?
      errors[:phone] = "手机号必需"
    else
      _user = User.find_by(telephone: phone)
      if mode == "sign_in" && _user.blank?
        errors[:phone] = "该手机号未注册"
      end
      if mode == "sign_up" && _user.present?
        errors[:phone] = "该手机号已注册"
      end
    end
    if captcha.blank?
      errors[:captcha] = "验证码必需"
    elsif !valid_captcha?(captcha)
      errors[:captcha] = "验证码错误"
    end

    respond_to do |format|
      if errors.blank?
        # 发送动态码
        # TODO dairg 发送动态码 这里不要用session，因为还要记录发送时间
        session[:phone_authcode] = '1111'
        session[:phone_authcode_send_time] = Time.new
        format.json { render json: {}}
      else
        format.json { render json: {errors: errors}}
        #format.json { render json: {}}
      end
    end
  end
end
