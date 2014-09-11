FactoryGirl.define do
  factory :admin do
    password 'password'
    password_confirmation 'password'
    sex 'male'
    factory :admin_with_role_editor do
      roles ['editor']
    end
  end
end
