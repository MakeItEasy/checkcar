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
    if self.new_record?
      validate_order_time
      validate_car_number
    else
      # 只有当以下相应的字段发生变更时才进行validate
      validate_order_time if self.order_time_changed?
      validate_car_number if self.car_number_area_changed? || self.car_number_detail_changed?
    end
  end

  ## Associations
  belongs_to :admin, foreign_key: :create_admin_id

end
