FactoryBot.define do
  factory :article do
    title {"title"}
    body {"ccccc"}
    created_at{0}
    updated_at{0}

    trait :archived do
      status {"archived"}
    end
    trait :other do
      sequence :status, %i[public private].cycle
    end
  end
end
