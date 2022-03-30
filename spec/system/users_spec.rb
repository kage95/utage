require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  
  context "ログイン済みとして" do
    before do
      sign_in @user
    end
    
    scenario "ログインする" do
      visit root_path
      expect(page).to have_content "マイページ"
    end
  
    scenario "マイページに遷移" do
      visit user_path(@user)
      expect(page).to have_content "#{@user.nickname}"
    end
  end
  
  context "未ログインとして" do
    
    scenario "新規宴会作成ページに行くとログインページに遷移" do
      visit new_event_path
      redirect_to new_user_session_path
    end
  
    scenario "マイページに行くとログインページに遷移" do
      visit user_path(@user)
      redirect_to new_user_session_path
    end
  end
  
end
