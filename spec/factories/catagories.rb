# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :catagory do
    factory :catagory1 do
      id 1
      name "车检知识"
      order 1
    end

    factory :catagory2 do
      id 2
      name "车检流程"
      order 2
    end

    factory :catagory3 do
      id 3
      name "维修知识"
      order 3
    end
  end
end
