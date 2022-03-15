class RoomChannel < ApplicationCable::Channel
  def subscribed
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @room = @event.room
    stream_from(@room)
    stream_for(@user)
  end

  def unsubscribed

  end

end
