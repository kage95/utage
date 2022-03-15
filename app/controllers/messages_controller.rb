class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create!(message_params)
    @room = Room.find_by(message_params[:room_id])
    RoomChannel.broadcast_to(current_user, message: @message.template,current_user: true)
    RoomChannel.broadcast_to(@room, message: @message.template,current_user: false)
  end

  private
    def message_params
      params.require(:message).permit(:content,:user_id,:room_id)
    end
end