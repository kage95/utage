class RoomsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @room = @event.room
    @messages = @room.messages
    @message = current_user.messages.build
  end
end
