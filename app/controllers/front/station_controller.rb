class Front::StationController < FrontController
  before_action :authenticate_user!, except: [:index]
  before_action :set_station, only: [:order, :create_order]

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
    session[:order_step] = nil
    session[:order_params] = {station_id: @station.id, user_id: current_user.id}
    @order = OrderNet.new(session[:order_params])
  end

  ## 预定成功画面
  def show_order
    @order = OrderNet.find(params[:order_id])
  end

  # POST
  def create_order
    session[:order_params].deep_merge!(order_params) if params[:order_net]
    @order = OrderNet.new(session[:order_params])
    @order.current_step = session[:order_step]

    if params[:back_button]
      # previous step
      @order.pre_step
    elsif @order.last_step?
      # submit
      @order.save
    else
      # next step
      @order.next_step if @order.valid?
    end
    session[:order_step] = @order.current_step 
    if @order.new_record?
      render :order
    else
      redirect_to front_station_show_order_path(@station, @order)
    end
  end

private
  def order_params
    params.require(:order_net).permit(:order_date, :order_time, :car_number, :owner_name, :telephone)
  end

  def set_station
    @station = Station.find(params[:id])
  end

end
