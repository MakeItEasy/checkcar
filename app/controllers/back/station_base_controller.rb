class Back::StationBaseController < BackController
  ## 面包屑导航
  add_breadcrumb "<i class='fa fa-home'></i>#{I18n.t('view.label.homepage')}".html_safe, :back_station_root_path
end
