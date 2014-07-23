class Front::User::OrdersController < Front::UserBaseController
  before_action :set_order, only: [:show, :cancel]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.user.orders'), :front_user_orders_path

  def index
    _orders = current_user.orders
    if params[:scope] && ['history'].include?(params[:scope])
      _orders = _orders.without_status("success")
    else
      _orders = _orders.success
    end
    @orders_grid = initialize_grid(_orders.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :front_user_orders_path
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :front_user_order_path
  end

  ## 取消预约
  # PATCH
  def cancel
    if can? :cancel, @order
      @order.update_column(:status, 'cancel')
      # redirect_to front_user_order_path(@order), notice: I18n.t("view.notice.order.cancelled")
      redirect_to request.referer, notice: I18n.t("view.notice.order.cancelled")
    end
  end

private
  def set_order
    @order = Order.accessible_by(current_ability).find(params[:id])
  end
end
