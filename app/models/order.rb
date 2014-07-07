class Order < ActiveRecord::Base
  extend Enumerize

  before_create :init_order_no

  ## Associations
  belongs_to :station

  ## Validations
  enumerize :status, in: Car::Code::ORDER_STATUS, default: :success, predicates: { prefix: true }, scope: true

  def init_order_no
    self.order_no = "order no"
  end
end
