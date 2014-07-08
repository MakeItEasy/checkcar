class Front::UserBaseController < FrontController
  # 认证需要
  before_action :authenticate_user!

  layout "front_user"

  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end
end
