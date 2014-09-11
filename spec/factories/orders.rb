# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    factory :order_with_car_number do
      type "OrderNet"
      car_number_area "陕"
      car_number_detail "A00001"
    end

    factory :order_with_car_area_only do
      type "OrderNet"
      car_number_area "陕"
    end
  end
end
