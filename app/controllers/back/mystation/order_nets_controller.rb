class Back::Mystation::OrderNetsController < Back::StationBaseController
  before_action :set_order_net, only: [:show]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  # TODO dairg 电话预约的面包屑
  add_breadcrumb Order.model_name.human, :back_mystation_orders_path

  # GET /order_nets/1
  # GET /order_nets/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_order_net_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_net
      @order_net = OrderNet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_net_params
      params.require(:order_net).permit(:order_date, :order_time,
        :owner_name, :car_number, :telenet)
    end
end
