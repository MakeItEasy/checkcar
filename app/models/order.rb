class Order < ActiveRecord::Base
  extend Enumerize

  before_create :init_order_no

  ## Scopes
  scope :today, -> { where(order_time: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :weekly, -> { where(order_time: (Time.now.midnight..Time.now.midnight+6.day)) }
  scope :newest, -> { where(created_at: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :expired, -> { where("order_time < ?", Time.now) }
  scope :not_cancelled, -> { without_status(:cancel) }
  scope :success, -> { with_status(:success) }
  # 过期并且满足自动batch处理条件，过期了X天
  scope :expired_for_auto_process, -> { where("order_time < ?", Time.now - Car::Constants::EXPIRED_DAYS_TO_AUTO_PROCESS.days) }

  ## Associations
  belongs_to :station

  ## Validations
  enumerize :status, in: Car::Code::ORDER_STATUS, default: :success, predicates: { prefix: true }, scope: true

  def init_order_no
    self.order_no = generate_order_no
  end

  def car_number
    self.car_number_area + self.car_number_detail if self.car_number_area && self.car_number_detail
  end

  ## 电话预约?
  def order_phone?
    self.is_a? OrderPhone 
  end

protected
  def validate_order_time
    # 因为可能用户提交的时候，那个时间段已经被其他人预约
    unless self.errors.include?(:order_time)
      _order_count = self.station.orders.success.where(order_time: self.order_time).count
      _limit_count = self.station.time_area_settings[self.order_time.hour-10]
      if _order_count >= _limit_count
        self.errors[:order_time] << I18n.t('view.alert.order.order_time_has_ordered')
      end
    end
  end
  def validate_car_number
    unless self.errors.include?(:car_number_area)  || self.errors.include?(:car_number_detail)
      # 车辆是否已经被预约check
      if Order.success.where(car_number_area: self.car_number_area, car_number_detail: self.car_number_detail).present?
        self.errors[:car_number_detail] << I18n.t('view.alert.order.car_has_ordered')
      end
    end
  end

private
  def generate_order_no
    self.station.prefix + I18n.l(Time.now, format: :nomark) + Array.new(4){ ('0'..'9').to_a[rand(10)] }.join
  end
end
