require 'rails_helper'

RSpec.describe Order, :type => :model do
  describe "car_number" do
    it "should be car area join car detail" do
      order = build(:order_with_car_number)
      expect(order.car_number).to eq(order.car_number_area + order.car_number_detail)
    end

    it "should be nil when car area is not present" do
      order = build(:order)
      expect(order.car_number).to be_nil
    end

    it "should be nil when car area is only present" do
      order = build(:order_with_car_area_only)
      expect(order.car_number).to be_nil
    end
  end
end
