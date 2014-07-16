class Back::Mystation::StationsController < Back::StationBaseController
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Station.model_name.human, :back_mystation_stations_path

  # GET /stations/1
  # GET /stations/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_station_path
  end

  # GET /stations/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_mystation_station_path
  end

  # station /stations
  # station /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to [:back, :mystation, @station], notice: I18n.t('view.notice.created') }
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
        format.html { redirect_to [:back, :mystation, @station], notice: I18n.t('view.notice.updated') }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:telephone, :recommend)
    end
end
