class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    @message = current_user.messages.create!(message_params)
    @room = Room.find(message_params[:room_id])
    RoomChannel.broadcast_to(@room, message: @message.template, user_id: current_user.id )
  end

  private
    def message_params
      params.require(:message).permit(:content,:user_id,:room_id)
    end
end