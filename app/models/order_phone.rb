## 电话预约订单
class OrderPhone < Order
  ## Scopes
  scope :today, -> { where(order_date: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :weekly, -> { where(order_date: (Time.now.midnight..Time.now.midnight+6.day)) }
  scope :newest, -> { where(created_at: (Time.now.midnight..Time.now.midnight+1.day)) }

  ## Validations
  validates :order_date, presence: true
  validates :order_time, presence: true
  validates :owner_name, presence: true, length: { maximum: 30 }
  validates :car_number, presence: true
  validates :telephone, presence: true

end
