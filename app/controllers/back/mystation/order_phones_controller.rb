class Back::Mystation::OrderPhonesController < Back::StationBaseController
  before_action :set_order_phone, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb OrderPhone.model_name.human, :back_mystation_order_phones_path

  # GET /order_phones
  # GET /order_phones.json
  def index
    _orders = OrderPhone
    if params[:scope] && ['today', 'weekly', 'newest'].include?(params[:scope])
      _orders = _orders.send(params[:scope])
    end
    # @order_phones_grid = initialize_grid(OrderPhone.accessible_by(current_ability))
    @order_phones_grid = initialize_grid(_orders.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_mystation_order_phones_path
  end

  # GET /order_phones/1
  # GET /order_phones/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_order_phone_path
  end

  # GET /order_phones/new
  def new
    @order_phone = OrderPhone.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_mystation_order_phone_path
  end

  # GET /order_phones/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_mystation_order_phone_path
  end

  # POST /order_phones
  # POST /order_phones.json
  def create
    @order_phone = OrderPhone.new(order_phone_params)
    @order_phone.station_id = current_admin.station.id
    respond_to do |format|
      if @order_phone.save
        format.html { redirect_to [:back, :mystation, @order_phone], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @order_phone }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @order_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_phones/1
  # PATCH/PUT /order_phones/1.json
  def update
    respond_to do |format|
      if @order_phone.update(order_phone_params)
        format.html { redirect_to [:back, :mystation, @order_phone], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @order_phone }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @order_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_phones/1
  # DELETE /order_phones/1.json
  def destroy
    @order_phone.destroy
    respond_to do |format|
      format.html { redirect_to back_mystation_order_phones_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_phone
      @order_phone = OrderPhone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_phone_params
      params.require(:order_phone).permit(:order_date, :order_time,
        :owner_name, :car_number, :telephone)
    end
end
