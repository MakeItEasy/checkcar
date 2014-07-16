class ApplicationController < ActionController::Base
  # 验证码重置 reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # TODO dairg rescue_from if Rails.env.production?
  if Rails.env.production?
    # 500错误
    rescue_from Exception, with: :render_500
    # 403错误
    rescue_from CanCan::AccessDenied, with: :render_403
    # 404错误
    rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404
  end


  # 参照link: https://gist.github.com/Sujimichi/2349565
  # called by last route matching unmatched routes.
  # Raises RoutingError which will be rescued from in the same way as other exceptions.
  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

protected

  ## override from devise
  def devise_parameter_sanitizer
    if resource_class == User
      Devise::UserParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

private 
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "devise_admin"
    else
      "devise_user"
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    resource_or_scope == :admin ? new_admin_session_path : root_path
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    return back_system_root_path if resource.is_a?(SystemAdmin)
    return back_station_root_path if resource.is_a?(StationAdmin)
    root_path
  end

  # render 404 error 
  def render_404(e)
    respond_to do |f| 
      f.html{ render :template => "errors/404", :status => 404 }
      # f.js{ render :partial => "errors/ajax_404", :status => 404 }
    end
  end

  # render 500 error 
  def render_500(e)
    respond_to do |f| 
      f.html{ render :template => "errors/500", :status => 500 }
      # f.js{ render :partial => "errors/ajax_500", :status => 500 }
    end
  end

end
