class Catagory < ActiveRecord::Base
  default_scope { order(order: :asc) }

  validates :name, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :order, presence: true, numericality: { only_integer: true, 
    greater_than_or_equal_to: 1, less_than: 100 }, uniqueness: true

  has_many :posts
end
