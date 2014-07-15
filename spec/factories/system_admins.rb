# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_admin do
    email 'admin@car.com'
    name '超级管理员'
    telephone "13100000001"
    password "password"
  end
end
