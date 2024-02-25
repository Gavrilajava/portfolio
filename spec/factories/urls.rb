FactoryBot.define do
  factory :url do
    long { "https://#{Faker::Internet.domain_name}?uuid=#{Faker::Internet.uuid}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
