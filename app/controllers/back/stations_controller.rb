class Back::StationsController < BackController
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Station.model_name.human, :back_stations_path

  # GET /stations
  # GET /stations.json
  def index
    @stations_grid = initialize_grid(Station,
                      :custom_order => {'stations.address' => '(stations.district+stations.address)'})
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_stations_path
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_station_path
  end

  # GET /stations/new
  def new
    @station = Station.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_station_path
  end

  # GET /stations/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_station_path
  end

  # station /stations
  # station /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to [:back, @station], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @station }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      @station.status = :waiting
      if @station.update(station_params)
        format.html { redirect_to [:back, @station], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to back_stations_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:name, :province, :city, :district, :address, :telephone, :recommend)
    end
end
