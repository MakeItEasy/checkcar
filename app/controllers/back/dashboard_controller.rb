class Back::DashboardController < BackController
  skip_authorization_check

  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.dashboard'), :back_root_path

  def index
  end
end
