require 'rails_helper'

RSpec.describe User, type: :model do
  it "バリデーションのテスト" do
      expect(FactoryBot.build(:user)).to be_valid
  end
  
  it "パスワードが6文字以下は保存されない" do
    user = FactoryBot.build(:user, password: "fooba")
      expect(user).to be_invalid
  end
  
  it "メールアドレスが256文字以上は保存されない" do
     user = FactoryBot.build(:user, email: "#{"a" * 256}")
      expect(user).to be_invalid
  end
  
  it "コメントが256文字以上は保存されない" do
    user = FactoryBot.build(:user, comment: "#{"a" * 256}")
      expect(user).to be_invalid
  end
    
  it "同じメールアドレスは使えない" do
    user1 = FactoryBot.create(:user)
    user = User.new(
      nickname: "テストユーザー",
      email: "#{user1.email}",
      comment: "コメントのテストです！！",
      password: "foobar"
      )
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
  end
end
