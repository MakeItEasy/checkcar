class Front::User::UaqsController < Front::UserBaseController
  before_action :set_uaq, only: [:show, :edit, :update, :destroy]

  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.uaqs'), :front_user_uaqs_path

  def index
    @uaqs = current_user.uaqs
  end

  # GET /uaqs/1
  # GET /uaqs/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :front_user_uaq_path
  end

  # GET /uaqs/new
  def new
    @uaq = Uaq.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_front_user_uaq_path
  end

  # GET /uaqs/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_front_user_uaq_path
  end

  # uaq /uaqs
  # uaq /uaqs.json
  def create
    @uaq = Uaq.new(uaq_params)
    @uaq.user_id = current_user.id

    respond_to do |format|
      if @uaq.save
        format.html { redirect_to [:front_user, @uaq], notice: I18n.t('view.notice.created') }
        # format.json { render :show, status: :created, location: @uaq }
        format.json { render json: {}, status: :created }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @uaq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uaqs/1
  # PATCH/PUT /uaqs/1.json
  def update
    respond_to do |format|
      @uaq.status = :waiting
      if @uaq.update(uaq_params)
        format.html { redirect_to [:front, :user, @uaq], notice: I18n.t('view.notice.updated') }
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

  # DELETE /uaqs/1
  # DELETE /uaqs/1.json
  def destroy
    @uaq.destroy
    respond_to do |format|
      format.html { redirect_to front_user_uaqs_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uaq
      @uaq = Uaq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uaq_params
      params.require(:uaq).permit(:question)
    end
end
