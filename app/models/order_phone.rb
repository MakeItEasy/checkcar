## 电话预约订单
class OrderPhone < Order
  ## Scopes
  scope :today, -> { where(order_date: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :weekly, -> { where(order_date: (Time.now.midnight..Time.now.midnight+6.day)) }
  scope :newest, -> { where(created_at: (Time.now.midnight..Time.now.midnight+1.day)) }
end
