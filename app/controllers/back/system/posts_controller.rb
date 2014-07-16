class Back::System::PostsController < Back::SystemBaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :complete]

  ## 加载权限
  load_and_authorize_resource

  ## 面包屑导航
  add_breadcrumb Post.model_name.human, :back_system_posts_path

  # GET /posts
  # GET /posts.json
  def index
    @posts_grid = initialize_grid(Post)
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.list'), :back_system_posts_path
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.show'), :back_system_post_path
  end

  # GET /posts/new
  def new
    @post = Post.new
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.new'), :new_back_system_post_path
  end

  # GET /posts/1/edit
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :edit_back_system_post_path
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.create_user_id = current_admin.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to [:back, :system, @post], notice: I18n.t('view.notice.created') }
        format.json { render :show, status: :created, location: @post }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.create')
          render :new
        end
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      @post.status = :draft
      if @post.update(post_params)
        format.html { redirect_to [:back, :system, @post], notice: I18n.t('view.notice.updated') }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to back_system_posts_url, notice: I18n.t('view.notice.deleted') }
      format.json { head :no_content }
    end
  end

  # PATCH /posts/1/complete
  # 完成
  def complete
    if @post.status_draft?
      @post.update_attributes!({status: 'waiting'})
      redirect_to [:back, :system, @post], notice: I18n.t("view.notice.post.completed")
    else
      redirect_to [:back, :system, @post], alert: I18n.t("view.alert.post.status_error")
    end
  end

  # PATCH /posts/1/publish
  # 发布
  def publish
    if @post.status_waiting?
      @post.update_attributes!({status: 'published', check_user_id: current_admin.id})
      redirect_to [:back, :system, @post], notice: I18n.t("view.notice.post.published")
    else
      redirect_to [:back, :system, @post], alert: I18n.t("view.alert.post.status_error")
    end
  end

  # PATCH /posts/1/reject
  # 拒绝
  def reject
    if @post.status_waiting?
      # TODO dairg 使用model box，填写理由
      @post.update_attributes!({status: 'rejected', check_user_id: current_admin.id})
      redirect_to [:back, :system, @post], notice: I18n.t("view.notice.post.rejected")
    else
      redirect_to [:back, :system, @post], alert: I18n.t("view.alert.post.status_error")
    end
  end

  # PATCH /posts/1/lock
  # 锁定
  def lock
    if @post.status_published?
      @post.update_attributes!({status: 'locked', lock_user_id: current_admin.id})
      redirect_to [:back, :system, @post], notice: I18n.t("view.notice.post.locked")
    else
      redirect_to [:back, :system, @post], alert: I18n.t("view.alert.post.status_error")
    end
  end

  # PATCH /posts/1/unlock
  # 解锁
  def unlock
    if @post.status_locked?
      @post.update_attributes!({status: 'published'})
      redirect_to [:back, :system, @post], notice: I18n.t("view.notice.post.unlocked")
    else
      redirect_to [:back, :system, @post], alert: I18n.t("view.alert.post.status_error")
    end
  end

  # TODO dairg 预览功能
  def preview
    redirect_to front_post_path(@post.catagory, @post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :catagory_id, :content)
    end
end
