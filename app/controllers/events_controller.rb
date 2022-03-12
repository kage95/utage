class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def select_restaurant
    @event = Event.new(event_params)
    session[:event] = @event
    redirect_to search_path
  end

  def confirm
    @restaurant = Restaurant.new(session[:restaurant])
    @event = Event.new(session[:event])
  end

  def create
    @event = Event.new(session[:event])
    render :new and return if params[:back]
    @restaurant = Restaurant.new(session[:restaurant])
    @restaurant.save
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

  private

  def event_params
    params.require(:event).permit(:date, :limit, :event_name, :detail)
  end
end
