class Front::OrdersController < FrontController
  before_action :authenticate_user!
  before_action :set_station

  ## 预定
  def new
    if message = current_user.can_order?
      flash[:alert] = I18n.t('view.alert.order.user_order_disable', reason: message)
      render "cannot_order", layout: "front"
    else
      session[:order_step] = nil
      session[:order_params] = {station_id: @station.id, user_id: current_user.id}
      @order = OrderNet.new(session[:order_params])
      set_current_order_states
    end
  end

  # POST
  def create
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
      render :new
    else
      session[:order_step] = session[:order_params] = nil
      redirect_to front_station_order_path(@station, @order)
    end
  end

  ## 预定成功画面
  def show
    @order = OrderNet.find(params[:id])
  end

private
  def order_params
    params.require(:order_net).permit(:order_time, :car_number_area, :car_number_detail, :owner_name, :telephone)
  end

  def set_station
    @station = Station.reviewed.find(params[:station_id])
  end

  def set_current_order_states
    @current_order_states = Car::OrderState.new(@station).current_order_states
  end
end
