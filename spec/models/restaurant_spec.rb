require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "バリデーションのテスト" do
    expect(FactoryBot.build(:restaurant)).to be_valid
  end
end
