class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @restaurant = Restaurant.new(session[:restaurant])
    @restaurant.save!
    @event = Event.new(event_params)
    @event.restaurant_id = @restaurant.id
    @event.save
    redirect_to event_path(@event.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event.id)
  end

  def index
    @events = Event.all
  end

  private

    def event_params
      params.require(:event).permit(:date, :limit, :event_name, :detail)
    end
end
