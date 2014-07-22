class Order < ActiveRecord::Base
  extend Enumerize

  before_create :init_order_no

  ## Scopes
  scope :today, -> { where(order_time: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :weekly, -> { where(order_time: (Time.now.midnight..Time.now.midnight+6.day)) }
  scope :newest, -> { where(created_at: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :expired, -> { where("order_time < ?", Time.now) }

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

private
  def generate_order_no
    self.station.prefix + I18n.l(Time.now, format: :nomark) + Array.new(4){ ('0'..'9').to_a[rand(10)] }.join
  end
end
