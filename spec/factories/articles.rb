# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :article do
    user { create :user }
    title { Faker::Food.dish }
    body { Faker::Food.description }
    sequence :status, %i[public private].cycle

    trait :archived do
      status { Article::ARCHIVED }
    end
  end
end
