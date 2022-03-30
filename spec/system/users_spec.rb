require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "ログインする" do
    user = FactoryBot.create(:user)
    sign_in user
    
    visit root_path
    expect(page).to have_content "マイページ"
  end
end
