require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションのテスト" do
    before do 
      @user = FactoryBot.build(:user)
    end
    context "ユーザーが登録できるとき" do
      it "カラムが正常に入力されている" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end
  
    context "ユーザーが保存できないとき" do
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
    end
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
