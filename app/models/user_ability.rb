class UserAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
  end

end
