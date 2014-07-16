class Back::System::SystemAdminsController < Back::SystemBaseController
  before_action :set_system_admin, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb SystemAdmin.model_name.human, :back_system_system_admins_path

  # GET /system_admins
  # GET /system_admins.json
  def index
    @system_admins_grid = initialize_grid(SystemAdmin)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_system_system_admins_path
  end

  # GET /system_admins/1
  # GET /system_admins/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_system_system_admin_path
  end

  # GET /system_admins/new
  def new
    @system_admin = SystemAdmin.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_system_system_admin_path
  end

  # GET /system_admins/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_system_system_admin_path
  end

  # POST /system_admins
  # POST /system_admins.json
  def create
    @system_admin = SystemAdmin.new(system_admin_params)

    respond_to do |format|
      if @system_admin.save
        format.html { redirect_to [:back, :system, @system_admin], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @system_admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_admins/1
  # PATCH/PUT /system_admins/1.json
  def update
    respond_to do |format|
      # if @system_admin.update(system_admin_params)
      if update_resource(@system_admin, system_admin_params)
        format.html { redirect_to [:back, :system, @system_admin], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @system_admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_admins/1
  # DELETE /system_admins/1.json
  def destroy
    @system_admin.destroy
    respond_to do |format|
      format.html { redirect_to back_system_system_admins_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_admin
      @system_admin = SystemAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_admin_params
      if params[:system_admin] && params[:system_admin][:roles]
        params[:system_admin][:roles].delete_if {|item| item.blank? }
      end
      params.require(:system_admin).permit(:email, :password, :name, :telephone, :password_confirmation, :sex, roles:[] )
    end

    def update_resource(object, attributes)
      update_method = attributes[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, attributes)
    end
end
