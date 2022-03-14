class RoomsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @memberships = @event.memberships
    redirect_to root_path unless @memberships.include?(user_id: current_user.id)
    @room = @event.room
    @messages = @room.messages
    @message = current_user.messages.build
  end
  
end
