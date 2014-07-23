## 电话预约订单
class OrderPhone < Order

  attr_accessor :order_date

  ## Validations
  validates :order_time, presence: true
  validates :owner_name, presence: true, length: { maximum: 30 }
  validates :car_number_area, presence: true
  validates :car_number_detail, presence: true
  validates :telephone, presence: true
  validate do 
    # 只有当以下相应的字段发生变更时才进行validate
    _origin_order = OrderPhone.find(self.id)
    validate_order_time if self.new_record? || self.order_time != _origin_order.order_time
    validate_car_number if self.new_record? || self.car_number_area != _origin_order.car_number_area || self.car_number_detail != _origin_order.car_number_detail
  end

  ## Associations
  belongs_to :admin, foreign_key: :create_admin_id

end
