class Back::System::UaqsController < Back::SystemBaseController
  before_action :set_uaq, only: [:show, :edit, :update]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Uaq.model_name.human, :back_system_uaqs_path

  # GET /uaqs
  # GET /uaqs.json
  def index
    if params[:scope] == "answered"
      @uaqs_grid = initialize_grid(Uaq.answered)
    elsif params[:scope] == "wait_answer"
      @uaqs_grid = initialize_grid(Uaq.wait_answer)
    else
      @uaqs_grid = initialize_grid(Uaq)
    end
    @count_infos = [Uaq.count, Uaq.wait_answer.count, Uaq.answered.count]
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_system_uaqs_path
  end

  # GET /uaqs/1
  # GET /uaqs/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_system_uaq_path
  end

  # GET /uaqs/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.answer'), :edit_back_system_uaq_path
  end

  # PATCH/PUT /uaqs/1
  # PATCH/PUT /uaqs/1.json
  def update
    @uaq.answering = true
    @uaq.answered_admin_id = current_admin.id
    respond_to do |format|
      if @uaq.update(uaq_params)
        format.html { redirect_to [:back, :system, @uaq], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @uaq }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @uaq.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uaq
      @uaq = Uaq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uaq_params
      params.require(:uaq).permit(:answer)
    end
end
