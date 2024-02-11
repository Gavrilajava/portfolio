FactoryBot.define do
  factory :contact_request do
    email { "MyString" }
    body { "MyText" }
    status { 1 }
  end
end
