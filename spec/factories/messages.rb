FactoryBot.define do
  factory :message do
    content { "バリデーションのテストです" }
    association :room
    association :user
  end
end
