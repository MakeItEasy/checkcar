class Back::AdminsController < BackController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Admin.model_name.human, :back_admins_path

  # GET /admins
  # GET /admins.json
  def index
    @admins_grid = initialize_grid(Admin)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_admins_path
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_admin_path
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_admin_path
  end

  # GET /admins/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_admin_path
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to [:back, @admin], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      # if @admin.update(admin_params)
      if update_resource(@admin, admin_params)
        format.html { redirect_to [:back, @admin], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to back_admins_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:email, :password, :name, :telephone, :password_confirmation, :sex, role_ids:[] )
    end

    def update_resource(object, attributes)
      update_method = attributes[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, attributes)
    end
end
