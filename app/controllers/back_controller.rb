class BackController < ApplicationController
  # 所以的action默认要确认是否都设置了权限检查
  check_authorization
  layout "back"

  # 认证需要
  before_action :authenticate_admin!

  # 无权限异常处理
=begin
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = I18n.t("view.alert.access_denied")
    redirect_to back_root_path, :alert => exception.message
  end
=end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin, namespace)
  end

private
  # render 404 error 
  def render_404(e)
    respond_to do |f| 
      f.html{ render :template => "back/errors/404", :status => 404 }
      # f.js{ render :partial => "errors/ajax_404", :status => 404 }
    end
  end

  # render 500 error 
  def render_500(e)
    respond_to do |f| 
      f.html{ render :template => "back/errors/500", :status => 500 }
      # f.js{ render :partial => "errors/ajax_500", :status => 500 }
    end
  end

  # render 403 error 
  def render_403(e)
    respond_to do |f| 
      f.html{ render :template => "back/errors/403", :status => 403 }
      # f.js{ render :partial => "errors/ajax_403", :status => 403 }
    end
  end

  def namespace
    # 2012.3.13 didn't work on Rails 3.0.7, cancan 1.6.7; looks promising, but needs some figuring out.
    #cns = @controller.class.to_s.split('::')
    #cns.size == 2 ? cns.shift.downcase : ""

    # I am sure there is a slicker way to capture the controller namespace
    # 2012.3.13 But it works!
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    # controller_namespace = controller_name_segments.join('/').camelize
    controller_namespace = controller_name_segments.join('/')
  end

end
