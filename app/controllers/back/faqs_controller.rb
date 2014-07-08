class Back::FaqsController < BackController
  before_action :set_faq, only: [:show, :edit, :update, :destroy]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Faq.model_name.human, :back_faqs_path

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs_grid = initialize_grid(Faq)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_faqs_path
  end

  # GET /faqs/1
  # GET /faqs/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_faq_path
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_faq_path
  end

  # GET /faqs/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_faq_path
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)
    @faq.create_user_id = current_admin.id

    respond_to do |format|
      if @faq.save
        format.html { redirect_to [:back, @faq], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @faq }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faqs/1
  # PATCH/PUT /faqs/1.json
  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to [:back, @faq], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to back_faqs_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_params
      params.require(:faq).permit(:question, :answer)
    end
end
