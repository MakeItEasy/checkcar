## 网上预约订单
class OrderNet < Order

  attr_writer :current_step

  ## Associations
  belongs_to :user

  ## Validations
  validates :order_time, presence: true, if: :step_select_date?
  validates :owner_name, presence: true, length: { maximum: 30 }, if: :step_basic_info?
  validates :car_number_area, presence: true, if: :step_basic_info?
  validates :car_number_detail, presence: true, if: :step_basic_info?
  validates :telephone, presence: true, if: :step_basic_info?

  ## 预约步骤
  def self.steps
    %w[select_station select_date basic_info confirmation]
  end

  def current_step
    @current_step || OrderNet.steps.second
  end

  def current_step_no
    OrderNet.steps.index(current_step)
  end

  def next_step
    @current_step = OrderNet.steps[current_step_no + 1]
  end

  def pre_step
    @current_step = OrderNet.steps[current_step_no - 1] if current_step_no > 1
  end

  def first_step?
    current_step == OrderNet.steps.second
  end

  def last_step?
    current_step == OrderNet.steps.last
  end

  def step_select_date?
    current_step == OrderNet.steps[1]
  end

  def step_basic_info?
    current_step == OrderNet.steps[2]
  end

  def all_valid?
    OrderNet.steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

end
