# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "陕西省汽车检测站#{n}"
  end

  factory :station do
    name 
    province "610000"
    city "610100"
    district "610102"
    address "高新区丈八六路58号"
    telephone "029-88605813"
    time_area_settings Array.new(8){20}
  end
end
