class RoomChannel < ApplicationCable::Channel
  def subscribed
    @event = Event.find(params[:event_id])
    @room = @event.room
    stream_for(@room)
  end

  def unsubscribed

  end

end
