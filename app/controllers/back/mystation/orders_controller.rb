class Back::Mystation::OrdersController < Back::StationBaseController

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Order.model_name.human, :back_mystation_orders_path

  # GET /orders
  # GET /orders.json
  def index
    _orders = Order
    if params[:scope] && ['today', 'weekly', 'newest'].include?(params[:scope])
      _orders = _orders.send(params[:scope])
    end
    @orders_grid = initialize_grid(_orders.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_mystation_orders_path
  end

end
