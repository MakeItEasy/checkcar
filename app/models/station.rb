class Station < ActiveRecord::Base

  extend Enumerize

  after_initialize :init

  ## Scopes
  default_scope { order(created_at: :asc) }
  scope :waiting, -> { with_status(:waiting) }
  scope :reviewed, -> { with_status(:reviewed) }
  scope :rejected, -> { with_status(:rejected) }
  scope :locked, -> { with_status(:locked) }
  scope :default_order, -> { order(created_at: :asc) }

  ## Validates
  validates :name, presence: true, length: { maximum: 20 }
  validates :province, presence: true
  validates :city, presence: true
  validates :district, presence: true
  validates :address, presence: true
  validates :telephone, presence: true
  enumerize :status, in: Car::Code::STATION_STATUS, default: :waiting, predicates: { prefix: true }, scope: true

  def init
    # 默认陕西省
    self.province = '610000'
  end
end
