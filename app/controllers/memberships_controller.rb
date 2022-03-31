class MembershipsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @membership = Membership.create(user_id: current_user.id, event_id: @event.id)
    redirect_to event_path(@event.id)
  end

  def destroy
    @event = Event.find(params[:id])
    @membership = Membership.find_by(user_id: current_user.id, event_id: @event.id)
    @membership.destroy
    redirect_to event_path(@event)
  end
end
