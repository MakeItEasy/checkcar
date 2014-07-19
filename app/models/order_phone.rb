## 电话预约订单
class OrderPhone < Order

  ## Validations
  validates :order_time, presence: true
  validates :owner_name, presence: true, length: { maximum: 30 }
  validates :car_number_area, presence: true
  validates :car_number_detail, presence: true
  validates :telephone, presence: true

  ## Associations
  belongs_to :admin, foreign_key: :create_admin_id

end
