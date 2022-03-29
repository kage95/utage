require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
      
  it "バリデーションのテスト" do
    event = FactoryBot.build(:event)
      expect(event).to be_valid
  end
  
  it "ユーザーと関連づけがないと保存できない" do
    event = FactoryBot.build(:event, planning_user: nil)
      expect(event).to be_invalid
  end
  
  it "飲食店の関連付けがないと保存できない" do
    event = FactoryBot.build(:event, restaurant: nil)
      expect(event).to be_invalid
  end
end
