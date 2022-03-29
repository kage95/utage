require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "バリデーションのテスト" do
    context "飲食店が保存できる時" do
      it "カラムが正常に保存されている" do
        expect(FactoryBot.build(:restaurant)).to be_valid
      end
    end
    
    context "飲食店が保存できない時" do
      it "店名がない" do
        expect(FactoryBot.build(:restaurant, name: nil)).to be_invalid
      end
      
      it "住所がない" do
        expect(FactoryBot.build(:restaurant, address: nil)).to be_invalid
      end
      
      it "キャッチワードがない" do
        expect(FactoryBot.build(:restaurant, catch: nil)).to be_invalid
      end
      
      it "店舗URLがない" do
        expect(FactoryBot.build(:restaurant, url: nil)).to be_invalid
      end
      
      it "画像URLがない" do
        expect(FactoryBot.build(:restaurant, image_url: nil)).to be_invalid
      end
    end
  end
end