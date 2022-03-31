class HomesController < ApplicationController
  def top
    @event_search_params = event_search_params
    new_events = Event.all.order(id: "DESC")
    @new_events = new_events.first(3)
    popular_events = Event.includes(:favorites).sort { |a, b| b.favorites.size <=> a.favorites.size }
    @popular_events = popular_events.first(3)
  end

  private

  def event_search_params
    params.fetch(:search, {}).permit(:event_name, :date, :prefecture_id)
  end
end
