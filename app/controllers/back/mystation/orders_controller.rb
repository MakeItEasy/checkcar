class Back::Mystation::OrdersController < Back::StationBaseController

  before_action :set_order, only: [:show, :cancel]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Order.model_name.human, :back_mystation_orders_path

  # GET /orders
  # GET /orders.json
  def index
    _orders = Order
    if params[:scope] && ['today', 'weekly', 'newest'].include?(params[:scope])
      _orders = _orders.success.send(params[:scope])
    end
    @orders_grid = initialize_grid(_orders.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_mystation_orders_path
  end

  # GET
  # 根据order_no查找order信息
  def show_order_no
    if params[:order_no]
      _order = Order.accessible_by(current_ability).where(order_no: params[:order_no]).first
      if _order.present?
        redirect_to [:back, :mystation, _order]
      end
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), back_mystation_order_path(@order)
  end

  ## 取消预约
  # PATCH
  def cancel
    if can? :cancel, @order
      @order.update_column(:status, 'cancel')
      redirect_to back_mystation_order_path(@order), notice: I18n.t("view.notice.order.cancelled")
    end
  end

  ## 按时来进行车检
  # PATCH
  def check
    if can? :check, @order
      @order.update_column(:status, 'checked')
      redirect_to back_mystation_order_path(@order), notice: I18n.t("view.notice.modify_status_success")
    end
  end

  ## 爽约
  # PATCH
  def missit
    if can? :missit, @order
      @order.update_column(:status, 'missit')
      redirect_to back_mystation_order_path(@order), notice: I18n.t("view.notice.modify_status_success")
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end
end
