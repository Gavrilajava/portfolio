FactoryBot.define do
  factory :user do
    name { Faker::Internet.name }
    role { :user }
    email { Faker::Internet.email }
    password { Faker::Internet.name }
    password_confirmation { password }
  end
end
