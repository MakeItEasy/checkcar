class Front::QuestionController < FrontController
  before_action :authenticate_user!, except: [:index_faq, :index_uaq]

  ## 常见问题
  def index_faq
    @faqs = Faq
    if params[:name_faq]
      _like_name_faq = "%#{params[:name_faq]}%"
      @faqs = @faqs.where("question like ? or answer like ?", _like_name_faq, _like_name_faq)
    end
    @faqs = @faqs.page(params[:page]).per(10)
  end

  ## 用户问题
  def index_uaq
  end
end
