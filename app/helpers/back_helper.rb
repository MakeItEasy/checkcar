module BackHelper
  ## 当前管理员的头像显示
  def render_current_user_image
    if current_admin.sex_male?
      image_tag "adminlte/avatar-male-1.png", class: "img-circle", alt:"User Image"
    else
      image_tag "adminlte/avatar-female-1.png", class: "img-circle", alt:"User Image"
    end
  end

  ## 当前管理员的角色
  def render_current_admin_roles
    current_admin.roles.collect {|r| I18n.t("enumerize.roles.#{current_admin.class.to_s.underscore}.#{r}")}.join(', ')
  end

  ## 角色collections渲染
  def admin_role_collections(type=:system)
    if type == :system
      Car::Code::SYSTEM_ROLES.collect do |r|
        [I18n.t("enumerize.roles.system_admin.#{r}"), r]
      end
    else
      Car::Code::STATION_ROLES.collect do |r|
        [I18n.t("enumerize.roles.station_admin.#{r}"), r]
      end
    end
  end

end

