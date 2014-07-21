class Back::StationBaseController < BackController
  ## 面包屑导航
  add_breadcrumb "<i class='fa fa-home'></i>#{I18n.t('view.label.homepage')}".html_safe, :back_mystation_root_path

protected
  # 当前station的设置
  def set_station
    @station = current_admin.station
  end

end
