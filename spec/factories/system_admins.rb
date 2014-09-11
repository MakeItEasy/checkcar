# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@car.com"
  end

  sequence :telephone do |n|
    "1810000000#{n}"
  end

  factory :system_admin do
    email
    name '超级管理员'
    sex 'male'
    telephone
    password "password"
    roles [:admin]

    factory :editor do
      name "编辑"
      roles [:editor]
    end
  end
end
