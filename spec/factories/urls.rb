FactoryBot.define do
  factory :url do
    long { "#{Faker::Internet.url}?uuid=#{Faker::Internet.uuid}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
