class Front::UserBaseController < FrontController
  # 认证需要
  before_action :authenticate_user!
end
