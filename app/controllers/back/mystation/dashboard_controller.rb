class Back::Mystation::DashboardController < Back::StationBaseController
  authorize_resource :class => false

  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.dashboard'), :back_mystation_root_path

  def index
    @newest_order_phone_count = Order.not_cancelled.newest.accessible_by(current_ability).count
  end
end
