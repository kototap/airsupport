FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 10) }
    user
    post
  end
end
