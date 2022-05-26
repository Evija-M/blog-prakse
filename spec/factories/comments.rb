FactoryBot.define do
  factory :comment do
    id {1}
    body {"body"}
    article_id{"13"}
    status {"public"}
  end
end