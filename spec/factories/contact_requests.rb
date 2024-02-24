FactoryBot.define do
  factory :contact_request do
    email { Faker::Internet.email }
    message { Faker::Marketing.buzzwords }
    status { :created }
  end
end
