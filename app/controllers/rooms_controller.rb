class RoomsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @memberships = @event.memberships.pluck(:user_id)
    redirect_to root_path unless @memberships.include?(current_user.id)
    @room = @event.room
    @messages = @room.messages.includes(:user)
    @message = current_user.messages.build
  end

end
