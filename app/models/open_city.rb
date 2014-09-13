class OpenCity < ActiveRecord::Base
  scope :default_order, -> { order(province_code: :asc, city_code: :asc) }

  ## Validations
  validates :name, presence: true, length: { maximum: 10 }
  validates :province_code, :city_code, presence: true
  validates :short_name, presence: true, length: { maximum: 20 }
  validates_uniqueness_of :name, :short_name, :city_code, allow_blank: true
  def self.is_valid_subdomain?(subdomain)
    subdomain.present? && OpenCity.find_by_short_name(subdomain).present?
  end
end
