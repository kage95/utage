require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "バリデーションのテスト" do
    
    context "宴会が保存できる時" do
      it "カラムが正常に入力されているとき" do
          expect(FactoryBot.build(:event)).to be_valid
      end
    end
      
    context "宴会が保存できないとき" do
      it "宴会名が21文字以上の時" do
        expect(FactoryBot.build(:event, event_name: "#{"a" * 21}")).to be_invalid
      end
      
      it "宴会詳細が256文字以上の時" do
        expect(FactoryBot.build(:event, detail: "#{"a" * 256}")).to be_invalid
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    it "ユーザーと関連づけがないと保存できない" do
      event = FactoryBot.build(:event, planning_user: nil)
        expect(event).to be_invalid
    end
    
    it "飲食店の関連付けがないと保存できない" do
      event = FactoryBot.build(:event, restaurant: nil)
        expect(event).to be_invalid
    end
  end
end
