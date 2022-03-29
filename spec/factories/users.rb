FactoryBot.define do
  factory :user, aliases: [:planning_user] do
    nickname { "テストユーザー" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    comment { "コメントのテストです" }
    password { "foobar" }
  end
end
