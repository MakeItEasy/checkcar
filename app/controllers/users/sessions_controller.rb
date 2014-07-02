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
      puts '===================================='
      puts Devise::UserParameterSanitizer.new(User, :user, params).sign_in
      puts self.resource
      self.resource.valid?
      clean_up_passwords(resource)
      flash[:alert] = "验证码错误"      
      flash.delete :recaptcha_error
      # flash[:recaptcha_error] = "There was an error with the recaptcha code below. Please re-enter the code."      
      render :new
    end
    
  end
end
