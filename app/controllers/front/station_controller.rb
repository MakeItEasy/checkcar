class Front::StationController < FrontController
  def index
    # session[:station_c_classonditions] = nil
    resultRelation = Station
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
    @stations = resultRelation.all
  end

  ## 预定
  def order
    @steps = steps
    @current_step = steps.first
    session[:current_step] = @current_step
  end

  def step
    @steps = steps
    @current_step = session[:current_step]
    if params[:type] == 'next'
      @current_step = steps[steps.index(@current_step)+1] || steps.first
    elsif params[:type] == 'pre'
      @current_step = steps[steps.index(@current_step)-1]
    end
    session[:current_step] = @current_step

    render :order
  end

private
  def steps
    %w[select_station select_date basic_info confirmation success]
  end

end
