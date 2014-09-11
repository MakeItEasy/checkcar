FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@car.com"
  end

  sequence :telephone do |n|
    "1810000000#{n}"
  end

  factory :admin do
    password 'password'
    password_confirmation 'password'
    sex 'male'
  end
end
