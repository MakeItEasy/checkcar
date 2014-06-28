class BackController < ApplicationController
  # 所以的action默认要确认是否都设置了权限检查
  check_authorization
  layout "back"

  # 认证需要
  before_action :authenticate_admin!

  ## 面包屑导航
  add_breadcrumb "<i class='fa fa-home'></i>#{I18n.t('view.label.homepage')}".html_safe, :back_root_path

  # 无权限异常处理
=begin
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = I18n.t("view.alert.access_denied")
    redirect_to back_root_path, :alert => exception.message
  end
=end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
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

end
