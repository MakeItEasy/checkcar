class Back::Mystation::OrderNetsController < Back::StationBaseController
  before_action :set_order_net, only: [:show]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb OrderNet.model_name.human, :back_mystation_orders_path

  private
    def set_order_net
      @order_net = OrderNet.find(params[:id])
    end
end
