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

    can :read, Order, :user_id => user.id

    can :cancel, Order do |order|
      order.user_id == user.id && 
      order.status_success? &&
      # order.order_time > (Time.now.midnight+Car::Constants::ORDER_CANCEL_ENABLE_DAYS.days)
      order.order_time > (Time.now.midnight+0.days)
    end
  end

end
