require 'rails_helper'

RSpec.describe "Restaurants", type: :system do
  scenario "飲食店を検索する", js: true do
    user = FactoryBot.create(:user)
    event_params = FactoryBot.attributes_for(:event)
    restaurant_params = FactoryBot.attributes_for(:restaurant)
    sign_in user
    
    visit search_path
    fill_in "restaurant_name_field", with: "肉"
    select "大阪", from: "restaurant_area_field"
    click_button "この条件で探す"
    expect(page).to have_content "肉"
  end
end
