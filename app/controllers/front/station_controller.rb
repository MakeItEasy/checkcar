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
    # TODO dairg per page setting
    @stations = resultRelation.page(params[:page]).per(1)
  end

  ## 预定
  def order
    session[:order_step] = nil
    session[:order_params] = {station_id: @station.id, user_id: current_user.id}
    @order = OrderNet.new(session[:order_params])
    set_current_order_states
  end

  # POST
  def create_order
    session[:order_params].deep_merge!(order_params) if params[:order_net]
    @order = OrderNet.new(session[:order_params])
    @order.current_step = session[:order_step]
    set_current_order_states

    if params[:back_button]
      # previous step
      @order.pre_step
    elsif @order.last_step?
      # submit
      if valid_captcha?(params[:captcha]) && @order.all_valid?
        # TODO dairg 其他验证，比如是否已经预约了其他了等等
        @order.save
      else
        flash[:alert] = I18n.t('view.alert.captcha_error')
      end
    else
      # next step
      @order.next_step if @order.valid?
    end
    session[:order_step] = @order.current_step 
    if @order.new_record?
      render :order
    else
      session[:order_step] = session[:order_params] = nil
      redirect_to front_station_show_order_path(@station, @order)
    end
  end

  ## 预定成功画面
  def show_order
    @order = OrderNet.find(params[:order_id])
  end


private
  def order_params
    params.require(:order_net).permit(:order_time, :car_number_area, :car_number_detail, :owner_name, :telephone)
  end

  def set_station
    @station = Station.find(params[:id])
  end

  def set_current_order_states
    @current_order_states = {
      Date.today => [2, 3, 0, 1, 2, 3, 2, 0],
      Date.tomorrow => [2, 3, 0, 1, 2, 3, 2, 0]
    }
  end
end
