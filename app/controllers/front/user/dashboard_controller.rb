class Front::User::DashboardController < Front::UserBaseController
  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.dashboard'), :front_user_root_path

  def index
    # 进行中预约
    @orders = current_user.orders.success.accessible_by(current_ability)
  end
end
