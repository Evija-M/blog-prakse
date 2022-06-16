# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :comment do
    association :user
    association :article
    commenter { Faker::Name.first_name }
    body { Faker::Lorem.sentence[2..10] }
  end
end
