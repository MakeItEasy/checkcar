class Users::ConfirmationsController < Devise::ConfirmationsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # 是否要点击邮件里面的确认后让客户直接登录，如果需要再次
  # 输入密码登录的话，那么就把这里的show和after_confirmation_path_for都注视掉，
  # 并且把route里面的confirmations也注释掉，用devise默认的即可, 同时需要修改locale中confirm内容
=begin
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    
    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      # 自动登录
      sign_in(resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

protected
  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?
      front_user_root_path
    else
      new_session_path(resource_name)
    end
  end
=end
end
