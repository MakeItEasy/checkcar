class Back::Station::DashboardController < Back::StationBaseController
  authorize_resource :class => false

  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.dashboard'), :back_station_root_path

  def index
  end
end
