FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number: 5) }
  end
end
