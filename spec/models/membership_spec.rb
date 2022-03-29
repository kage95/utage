require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe "アソシエーションのテスト" do
    context "保存できる時" do
      it "ユーザーと宴会と両方に関連付けられている" do
        expect(FactoryBot.build(:membership)).to be_valid
      end
    end
    
    context "保存できない時" do
      it "宴会に関連付けられていない" do
        expect(FactoryBot.build(:membership, event: nil)).to be_invalid
      end
      it "ユーザーと関連付けられていない" do
        expect(FactoryBot.build(:membership, user: nil)).to be_invalid
      end
    end
  end
end
