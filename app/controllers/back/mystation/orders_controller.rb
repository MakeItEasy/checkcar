class Back::Mystation::OrdersController < Back::StationBaseController
  before_action :set_order, only: [:show]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Order.model_name.human, :back_mystation_orders_path

  # GET /order_phones
  # GET /order_phones.json
  def index
    _orders = Order
    if params[:scope] && ['today', 'weekly', 'newest'].include?(params[:scope])
      _orders = _orders.send(params[:scope])
    end
    # @order_phones_grid = initialize_grid(OrderPhone.accessible_by(current_ability))
    @order_phones_grid = initialize_grid(_orders.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_mystation_orders_path
  end

  # GET /order_phones/1
  # GET /order_phones/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_order_phone_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order_phone = OrderPhone.find(params[:id])
    end
end
