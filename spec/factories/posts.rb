# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :title do |n|
    "post title #{n}"
  end
  sequence :content do |n|
    "post content #{n}"
  end

  factory :post do
    title
    content 

    association :catagory, factory: :catagory1
    association :admin, factory: :system_admin

    trait :published do
      status :published
    end

    factory :published_post, traits: [:published]
  end
end
