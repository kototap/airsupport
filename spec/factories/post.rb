FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 5) }
    body { Faker::Lorem.characters(number: 10) }
    airport { Faker::Lorem.characters(number: 5) }
    address { Faker::Address.full_address }
    user

    after(:create) do |post|
      create_list(:post_tag, 1, post: post, tag: create(:tag))
    end
  end
end
