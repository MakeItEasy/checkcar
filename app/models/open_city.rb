class OpenCity < ActiveRecord::Base
  default_scope { order(province_code: :asc, city_code: :asc) }
  def self.is_valid_subdomain?(subdomain)
    subdomain.present? && OpenCity.find_by_short_name(subdomain).present?
  end
end
