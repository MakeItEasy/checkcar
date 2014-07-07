# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    type ""
    user_id 1
    station_id 1
  end
end
