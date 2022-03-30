require 'rails_helper'

RSpec.describe "Events", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "新規宴会情報を入力する" do
    user = FactoryBot.create(:user)
    event_params = FactoryBot.attributes_for(:event)
    sign_in user

    visit new_event_path
    fill_in "event_name_field", with: event_params[:event_name]
    select "大阪府", from: "event_prefecture_field"
    fill_in "event_date_field", with: event_params[:date]
    fill_in "event_limit_field", with: event_params[:limit]
    fill_in "event_detail_field", with: event_params[:detail]
    click_button "飲食店を決める →"
    expect(page).to have_content "検索条件"
  end
  
end
