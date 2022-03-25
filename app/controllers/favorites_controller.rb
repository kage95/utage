class FavoritesController < ApplicationController
  def create
    @event = Event.find_by(params[:event_id])
    current_user.favorites.create!(event_id: @event.id)
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    favorite = current_user.favorites.find_by(event_id: @event.id)
    favorite.destroy
  end
end
