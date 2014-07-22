class AdminAbility
  include CanCan::Ability

  def initialize(user, namespace)
    user ||= SystemAdmin.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    alias_action :create, :read, :update, :to => :cru

    if ['back/system', 'back'].include?(namespace) && user.system_admin?
      set_ability_system_common(user)
      # 超级管理员
      set_ability_system_superadmin(user) if user.has_role?("superadmin")
      # TODO dairg QA 版主和编辑的责任划分
      set_ability_system_moderator(user) if user.has_role?("moderator")
      set_ability_system_editor(user) if user.has_role?("editor")
    end
    if ['back/mystation', 'back'].include?(namespace) && user.station_admin?
      set_ability_station_common(user)
      set_ability_station_admin(user) if user.has_role?("admin")
      set_ability_station_normal(user) if user.has_role?("normal")
    end

    ## 不能删除id为1的超级管理员
    cannot :destroy, SystemAdmin, :id => 1

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

private

  ## ========================================================================
  ## 系统管理员权限管理
  ## ========================================================================

  # 基本权限
  def set_ability_system_common(user)
    can :index, :dashboard
  end

  # 超级管理员
  def set_ability_system_superadmin(user)
    # TODO dairg 不要用manage all，而是吧每个权限都细标出来
    # can :manage, :all
    can :crud, :all
  end

  # 版主
  def set_ability_system_moderator(user)
    can :read, Catagory
    can :read, Post
    can :destroy, Post
    can :publish, Post, :status => "waiting"
    can :reject, Post, :status => "waiting"
    can :lock, Post, :status => "published"
    can :unlock, Post, :status => "locked"
    can :preview, Post
    # 可以删除附件以及图片
    can :destroy, Ckeditor::Picture
    can :destroy, Ckeditor::AttachmentFile
  end

  # 编辑
  def set_ability_system_editor(user)
    can :read, Catagory
    can :read, Post
    can :create, Post
    can :update, Post, :create_user_id => user.id
    can :complete, Post, :create_user_id => user.id, :status => "draft"
    can :preview, Post

    # FAQ
    can :read, Faq
    can :create, Faq
    can :update, Faq, :create_user_id => user.id
    can :destroy, Faq, :create_user_id => user.id
    # 用户问题
    can :read, Uaq
    can :update, Uaq, :answered_admin_id => nil

    # Always performed
    # needed to access Ckeditor filebrowser
    can :access, :ckeditor
    can :read, Ckeditor::Picture
    can :create, Ckeditor::Picture
    can :read, Ckeditor::AttachmentFile
    can :create, Ckeditor::AttachmentFile
  end

  ## ========================================================================
  ## 车检站管理
  ## ========================================================================

  # 基本权限
  def set_ability_station_common(user)
    can :index, :dashboard
  end

  # 管理员
  def set_ability_station_admin(user)
    if user.station.status_reviewed?
      can :crud, StationAdmin, station_id: user.station.id
      can :update, Station, id: user.station.id
      can :create, OrderPhone, station_id: user.station.id
      can :read, OrderPhone, station_id: user.station.id
      # TODO dairg 编辑电话预约的条件，比如状态，以及预约时间范围
      can :update, OrderPhone, station_id: user.station.id 
      can :read, Order, station_id: user.station.id
      can :cancel, OrderPhone do |order|
        order.station_id == user.station.id && 
        order.status_success? &&
        order.order_time > (Time.now.midnight+Car::Constants::ORDER_CANCEL_ENABLE_DAYS.days)
      end
      can [:check, :missit], Order do |order|
        order.station_id == user.station.id && 
        order.status_success? &&
        order.order_time < Time.now
      end
      can :show_order_no, Order, station_id: user.station.id
      can :time_area, :station_setting
      can :update_time_area, :station_setting
    end
    # 显示设置中心菜单
    can :show, :settings
    can :show, Station, id: user.station.id
  end

  # 普通员工
  def set_ability_station_normal(user)
    can :cru, OrderPhone, station_id: user.station.id
    can :read, Order, station_id: user.station.id
    can :show_order_no, Order, station_id: user.station.id
  end
end
