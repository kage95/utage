class HomesController < ApplicationController
  def top
    @event_search_params = event_search_params
    @new_events = Event.all.limit(3)
    @popular_events = Event.includes(:favorites).limit(3).sort{ |a,b| b.favorites.size <=> a.favorites.size }
  end
  
  private
  
    def event_search_params
      params.fetch(:search, {}).permit(:event_name,:date,:prefecture_id)
    end
end
