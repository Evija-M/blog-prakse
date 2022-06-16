# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    trait :admin do
      role { 'admin' }
    end
    trait :registred do
      role { 'registred' }
    end
  end
end
