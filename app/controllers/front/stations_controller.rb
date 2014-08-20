class Front::StationsController < FrontController
  before_action :set_station, only: [:show]
  def index
    # session[:station_c_classonditions] = nil
    resultRelation = Station.reviewed
    session[:station_conditions] = session[:station_conditions] || {}

    ## unselect处理
    session[:station_conditions].delete('district') if params[:undistrict]
    session[:station_conditions].delete('name') if params[:unname]
    ## select处理
    # 行政区域
    session[:station_conditions]['district'] = params[:district] if params[:district]
    if session[:station_conditions]['district'].present?
      resultRelation = resultRelation.where({district: session[:station_conditions]['district']})
    end
    # 名称查询
    session[:station_conditions]['name'] = params[:name] if params[:name]
    if session[:station_conditions]['name']
      resultRelation = resultRelation.where('name like ?', '%' + session[:station_conditions]['name'] + '%')
    end
    # TODO dairg per page setting
    @stations = resultRelation.page(params[:page]).per(10)
  end

  def show
    
  end

private
  def set_station
    @station = Station.reviewed.find(params[:id])
  end
end
