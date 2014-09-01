class Back::Mystation::StationAdminsController < Back::StationBaseController
  before_action :set_station_admin, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb StationAdmin.model_name.human, :back_mystation_station_admins_path

  # GET /station_admins
  # GET /station_admins.json
  def index
    @station_admins_grid = initialize_grid(StationAdmin.accessible_by(current_ability))
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_mystation_station_admins_path
  end

  # GET /station_admins/1
  # GET /station_admins/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_mystation_station_admin_path
  end

  # GET /station_admins/new
  def new
    @station_admin = StationAdmin.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_mystation_station_admin_path
  end

  # GET /station_admins/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_mystation_station_admin_path
  end

  # POST /station_admins
  # POST /station_admins.json
  def create
    @station_admin = StationAdmin.new(station_admin_params)
    @station_admin.station = current_admin.station
    @station_admin.roles = ['normal']
    respond_to do |format|
      if @station_admin.save
        format.html { redirect_to [:back, :mystation, @station_admin], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @station_admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @station_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /station_admins/1
  # PATCH/PUT /station_admins/1.json
  def update
    respond_to do |format|
      # if @station_admin.update(station_admin_params)
      if update_resource(@station_admin, station_admin_params)
        format.html { redirect_to [:back, :mystation, @station_admin], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @station_admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @station_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /station_admins/1
  # DELETE /station_admins/1.json
  def destroy
    @station_admin.destroy
    respond_to do |format|
      format.html { redirect_to back_mystation_station_admins_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_admin
      @station_admin = StationAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_admin_params
      params.require(:station_admin).permit(:email, :password, :name, :telephone, :password_confirmation, :sex)
      # 不可以修改roles
=begin
      if params[:station_admin] && params[:station_admin][:roles]
        params[:station_admin][:roles].delete_if {|item| item.blank? }
      end
      params.require(:station_admin).permit(:email, :password, :name, :telephone, :password_confirmation,
                                            :sex, roles:[])
=end
    end

    def update_resource(object, attributes)
      update_method = attributes[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, attributes)
    end
end
