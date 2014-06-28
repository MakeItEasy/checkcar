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
    current_admin.roles.collect {|r| r.label}.join(', ')
  end

end

