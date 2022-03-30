FactoryBot.define do
  factory :event do
    event_name { "宴会のテストです" }
    date { Time.current + 2 }
    limit { 1 }
    detail { "宴会のテストです" }
    association :planning_user
    association :restaurant
    
      trait :with_restaurant do
        restaurant { FactoryBot.create(:restaurant) }
      end
  end
end
