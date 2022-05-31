# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :article do
    user { create :user }
    title { Faker::Food.dish }
    body { Faker::Food.description }
    trait :archived do
      status { Article::ARCHIVED }
    end
    trait :other do
      sequence :status, %i[public private].cycle
    end
  end
end
