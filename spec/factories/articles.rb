require 'faker'

FactoryBot.define do
  factory :article do
    title {Faker::Food.dish}
    body {Faker::Food.description}

    trait :archived do
      status {ARCHIVED = 'archived'}
    end
    trait :other do
      sequence :status, %i[public private].cycle
    end
  end
end
