class Front::User::PersonalController < Front::UserBaseController
  # 这个controller中的action不用进行权限检查
  skip_authorization_check

  before_action :set_user, only: [:show, :password, :edit, :update, :update_password]
  ## 面包屑导航
  add_breadcrumb I18n.t('view.controller.personal'), :front_user_personal_show_path

  # 个人信息
  def show
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.personal.show'), :front_user_personal_show_path
  end

  # 修改密码
  def password
    ## 面包屑导航
    add_breadcrumb I18n.t('view.action.personal.password'), :front_user_personal_password_path
  end

  def update_password
    respond_to do |format|
      @user.password_required = true
      if @user.update_with_password(params.require(:user).permit(:current_password, :password, :password_confirmation))
        format.html do
          sign_in @user, :bypass => true
          redirect_to front_user_personal_show_path, notice: I18n.t('view.notice.modify_password_success')
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
    add_breadcrumb I18n.t('view.action.edit'), :front_user_personal_edit_path
  end

  def update
    respond_to do |format|
      if @user.update_without_password(personal_params)
        format.html { redirect_to front_user_personal_show_path, notice: I18n.t('view.notice.updated') }
      else
        format.html do
          flash[:alert] = I18n.t('view.alert.update')
          render :edit
        end
      end
    end
  end

  private
    def set_user
      @user = current_user
    end

    def personal_params
      params.require(:user).permit(:name, :sex, :email)
    end
end
