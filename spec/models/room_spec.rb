require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "アソシエーションのテスト" do
    context "保存できる時" do
      it "特定の宴会と関連付けられている" do
        expect(FactoryBot.build(:room)).to be_valid
      end
    end

    context "保存できない時" do
      it "特定の宴会と関連付けられていない" do
        expect(FactoryBot.build(:room, event: nil)).to be_invalid
      end
    end
  end
end
