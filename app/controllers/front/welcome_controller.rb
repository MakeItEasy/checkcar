class Front::WelcomeController < FrontController

  before_action :set_catagory, only: [:list_posts, :show_post ]

  ## 主页
  def index
  end

  ## 文章列表页
  def list_posts
    # TODO dairg 404共通页面处理
  end

  ## 文章明细页
  def show_post
    @post = Post.find(params[:post_id])
    # 如果post不是发布状态，那么返回404
    # raise ActiveRecord::RecordNotFound unless @post.status_published?
    @pre_post = @post.pre_published_post
    @next_post = @post.next_published_post
  end

  ## 预约
  # TODO dairg 暂时放到这里
  def order
    @steps = steps
    @current_step = steps.first
    session[:current_step] = @current_step
  end

  def step
    @steps = steps
    @current_step = session[:current_step]
    if params[:type] == 'next'
      @current_step = steps[steps.index(@current_step)+1] || steps.first
    elsif params[:type] == 'pre'
      @current_step = steps[steps.index(@current_step)-1]
    end
    session[:current_step] = @current_step

    render :order
  end

private
  def steps
    %w[select_station select_date basic_info confirmation success]
  end

  def set_catagory
    @catagory = Catagory.find(params[:catagory_id])
  end

end
