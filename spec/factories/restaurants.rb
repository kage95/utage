FactoryBot.define do
  factory :restaurant do
    name { "お店のテスト" }
    address { "住所のテスト" }
    catch { "キャッチのテスト" }
    url { "example.com" }
    image_url { "example.com" }
  end
end
