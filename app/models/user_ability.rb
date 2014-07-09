class UserAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud

    ## 用户问题相关
    can :read, Uaq, :create_user_id => user.id
    can :create, Uaq
    can :update, Uaq, :create_user_id => user.id
    can :destroy, Uaq, :create_user_id => user.id
  end

end
