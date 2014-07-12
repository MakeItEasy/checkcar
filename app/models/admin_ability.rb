class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Admin.new
    alias_action :create, :read, :update, :destroy, :to => :crud

    # 超级管理员
    set_ability_superadmin(user) if user.is_superadmin?
    # TODO dairg QA 版主和编辑的责任划分
    set_ability_moderator(user) if user.is_moderator?
    set_ability_editor(user) if user.is_editor?

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

  # 超级管理员
  def set_ability_superadmin(user)
    # TODO dairg 不要用manage all，而是吧每个权限都细标出来
    # can :manage, :all
    can :crud, :all
  end

  # 版主
  def set_ability_moderator(user)
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
  def set_ability_editor(user)
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
end
