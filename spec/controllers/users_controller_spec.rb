require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#show" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "ログイン済みユーザーとして" do
      it "正常にレスポンスを返す" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end

    context "未ログインユーザーとして" do
      it "ログインページにリダイレクト" do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
