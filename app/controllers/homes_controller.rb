class HomesController < ApplicationController
  def top
    @event_search_params = event_search_params
    @events = Event.all
  end
  
  private
  
    def event_search_params
      params.fetch(:search, {}).permit(:event_name,:date,:prefecture_id)
    end
end
