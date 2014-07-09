class Front::UserBaseController < FrontController
  # 认证需要
  before_action :authenticate_user!

  layout "front_user"

  ## 面包屑导航
  add_breadcrumb "<i class='fa fa-home'></i>#{I18n.t('view.label.homepage')}".html_safe, :front_user_root_path

  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end
end
