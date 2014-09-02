class Back::Mystation::StationSettingsController < Back::StationBaseController
  before_action :set_station, only: [:time_area, :update_time_area]

  ## 加载权限
  authorize_resource :class => false

  ## GET
  ## 可预约时间段的设置
  def time_area
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.time_area'), :back_mystation_station_settings_time_area_path
  end

  ## PUT
  def update_time_area
    if valid_time_area_settings? 
      params[:station][:time_area_settings].collect! do |c|
        c.to_i > Car::Constants::TIME_AREA_SETTING_MAX ? Car::Constants::TIME_AREA_SETTING_MAX : c.to_i
      end
      if @station.update(time_area_params)
        redirect_to back_mystation_station_settings_time_area_path, notice: I18n.t('view.notice.updated')
      else
        flash[:alert] = I18n.t('view.alert.update')
        render :time_area
      end
    else
      flash[:alert] = I18n.t('view.alert.update')
      render :time_area
    end
  end

private
  def time_area_params
    params.require(:station).permit(time_area_settings:[])
  end

  ## 验证area settings
  def valid_time_area_settings?
    true
  end
end
