class Back::System::CatagoriesController < Back::SystemBaseController
  before_action :set_catagory, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Catagory.model_name.human, :back_system_catagories_path

  # GET /catagories
  # GET /catagories.json
  def index
    @catagories_grid = initialize_grid(Catagory)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_system_catagories_path
  end

  # GET /catagories/1
  # GET /catagories/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_system_catagory_path
  end

  # GET /catagories/new
  def new
    @catagory = Catagory.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_system_catagory_path
  end

  # GET /catagories/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_system_catagory_path
  end

  # POST /catagories
  # POST /catagories.json
  def create
    @catagory = Catagory.new(catagory_params)

    respond_to do |format|
      if @catagory.save
        format.html { redirect_to [:back, :system, @catagory], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @catagory }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @catagory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catagories/1
  # PATCH/PUT /catagories/1.json
  def update
    respond_to do |format|
      # if @catagory.update(catagory_params)
      if @catagory.update_attributes(catagory_params)
        format.html { redirect_to [:back, :system, @catagory], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @catagory }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @catagory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catagories/1
  # DELETE /catagories/1.json
  def destroy
    @catagory.destroy
    respond_to do |format|
      format.html { redirect_to back_system_catagories_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catagory
      @catagory = Catagory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catagory_params
      params.require(:catagory).permit(:name, :order, :memo)
    end
end
