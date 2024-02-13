FactoryBot.define do
  factory :user do
    name { Faker::Internet.name }
    email { Faker::Internet.email }
    password { Faker::Internet.name }
    password_confirmation { password }
  end
end
