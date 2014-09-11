# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_admin do
    email
    name '超级管理员'
    sex 'male'
    telephone
    password "password"
    roles ["superadmin"]

    factory :super_admin do
      name "超级管理员"
      roles ["superadmin"]
    end

    factory :editor do
      name "编辑"
      roles ["editor"]
    end

    factory :moderator do
      name "版主"
      roles ["moderator"]
    end
  end
end
