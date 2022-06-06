# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    after(:build)   { |u| u.skip_confirmation_notification! }
    after(:create)  { |u| u.confirm }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
