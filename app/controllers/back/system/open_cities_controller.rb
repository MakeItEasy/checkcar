class Back::System::OpenCitiesController < Back::SystemBaseController
  before_action :set_open_city, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb OpenCity.model_name.human, :back_system_open_cities_path

  # GET /open_cities
  # GET /open_cities.json
  def index
    @open_cities_grid = initialize_grid(OpenCity)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_system_open_cities_path
  end

  # GET /open_cities/1
  # GET /open_cities/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_system_open_city_path
  end

  # GET /open_cities/new
  def new
    @open_city = OpenCity.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_system_open_city_path
  end

  # GET /open_cities/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_system_open_city_path
  end

  # POST /open_cities
  # POST /open_cities.json
  def create
    @open_city = OpenCity.new(open_city_params)

    respond_to do |format|
      if @open_city.save
        format.html { redirect_to [:back, :system, @open_city], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @open_city }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @open_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /open_cities/1
  # PATCH/PUT /open_cities/1.json
  def update
    respond_to do |format|
      if @open_city.update(open_city_params)
        format.html { redirect_to [:back, :system, @open_city], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @open_city }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @open_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_cities/1
  # DELETE /open_cities/1.json
  def destroy
    @open_city.destroy
    respond_to do |format|
      format.html { redirect_to back_system_open_cities_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_city
      @open_city = OpenCity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_city_params
      params.require(:open_city).permit(:name, :province_code, :city_code, :short_name)
    end
end
