class Order < ActiveRecord::Base
  extend Enumerize

  before_create :init_order_no

  ## Scopes
  scope :today, -> { where(order_date: (Time.now.midnight..Time.now.midnight+1.day)) }
  scope :weekly, -> { where(order_date: (Time.now.midnight..Time.now.midnight+6.day)) }
  scope :newest, -> { where(created_at: (Time.now.midnight..Time.now.midnight+1.day)) }

  ## Associations
  belongs_to :station

  ## Validations
  enumerize :status, in: Car::Code::ORDER_STATUS, default: :success, predicates: { prefix: true }, scope: true

  def init_order_no
    self.order_no = "order no"
  end

  def order_time_text
     self.order_time + ":00" if self.order_time.present?
  end
end
