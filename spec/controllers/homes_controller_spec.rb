require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  describe "#top" do
    it "正常にレスポンスを返す" do
      get :top
      expect(response).to be_successful
    end
  end
end
