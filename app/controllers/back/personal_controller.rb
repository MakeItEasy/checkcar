class Back::PersonalController < BackController
  # 这个controller中的action不用进行权限检查
  skip_authorization_check

  before_action :set_admin, only: [:show, :password, :edit, :update, :update_password]
  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.personal'), :back_personal_show_path

  # 个人信息
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.personal.show'), :back_personal_show_path
  end

  # 修改密码
  def password
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.personal.password'), :back_personal_password_path
  end

  def update_password
    respond_to do |format|
      @admin.password_required = true
      if @admin.update_with_password(params.require(@admin.class.to_s.underscore).permit(:current_password, :password, :password_confirmation))
        format.html do
          sign_in @admin, :bypass => true
          redirect_to back_personal_show_path, notice: I18n.t('view.notice.modify_password_success')
        end
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :password
        end
      end
    end
  end

  # 编辑
  def edit
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.edit'), :back_personal_edit_path
  end

  def update
    respond_to do |format|
      if @admin.update_without_password(personal_params)
        format.html { redirect_to back_personal_show_path, notice: I18n.t('view.notice.updated') }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = current_admin
    end

    def personal_params
      params.require(@admin.class.to_s.underscore).permit(:name, :telephone, :sex)
    end
end
