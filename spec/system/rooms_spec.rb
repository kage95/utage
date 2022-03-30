require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @event = FactoryBot.create(:event)
    @room = FactoryBot.create(:room, event: @event)
    @message = FactoryBot.create(:message, user: @user, room: @room)
  end
  
  context "宴会の参加者である時" do
    before do
      FactoryBot.create(:membership, user: @user, event: @event)
    end
    
    scenario "チャットルームに遷移" do
      visit event_rooms_path(@event)
      expect(page).to have_content "#{@message.content}"
    end
  end
end
