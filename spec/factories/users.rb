# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'default@car.com'
    password 'password'
    password_confirmation 'password'
    sex 'male'

    factory :user_only_email do
      email 'user1@car.com'
    end
    factory :user_only_telephone do
      email nil
      telephone '18100000001'
    end
    factory :user_with_name_and_email do
      name '普通用户'
      email 'user2@car.com'
    end

    factory :confirmed_user do
      email 'confirm_user@car.com'
      confirmed_at {1.day.ago}
    end

    factory :user_who_has_orders do
      email "user_who_has_orders@car.com"
      ignore do
        net_orders_count 3
      end
      after(:create) do |user, evaluator|
        create_list(:order_net, evaluator.net_orders_count, user: user)
      end
    end
  end
end
