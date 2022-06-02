# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user { create :user }
    article { create :article, :other }
    commenter { Faker::Name.first_name }
    body { Faker::Lorem.sentence[2..10] }
  end
end
