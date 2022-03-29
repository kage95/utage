require 'rails_helper'

RSpec.describe Message, type: :model do
  
  describe "バリデーションのテスト" do
    context "保存できる時" do
      it "メッセージが入力されている" do
        expect(FactoryBot.build(:message)).to be_valid
      end
    end
    
    context "保存できない時" do
      it "メッセージが256文字以上の時" do
        expect(FactoryBot.build(:message, content: "#{"a" * 256}")).to be_invalid
      end
      it "メッセージが入力されていない" do
        expect(FactoryBot.build(:message, content: nil)).to be_invalid
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    context "保存できる時" do
      it "特定のルームとユーザーに関連付けられている" do
        expect(FactoryBot.build(:message)).to be_valid
      end
    end
    
    context "保存できない時" do
      it "ルームと関連付けられていない" do
        expect(FactoryBot.build(:message, room: nil)).to be_invalid
      end
      it "ユーザーと関連付けられていない" do
        expect(FactoryBot.build(:message, user: nil)).to be_invalid
      end
    end
  end
end
