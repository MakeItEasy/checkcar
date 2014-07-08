class Front::QuestionController < FrontController
  before_action :authenticate_user!, except: [:index_faq, :index_uaq]

  ## 常见问题
  def index_faq
  end

  ## 用户问题
  def index_uaq
  end
end
