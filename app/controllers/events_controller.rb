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
    @event.user_id = current_user.id
    @event.save
    Membership.create(user_id: current_user.id, event_id: @event.id)
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
  
  def future_events
    @user = User.find(params[:user_id])
    @events = @user.events
    @event_list = []
    @events.each do |event| 
      if event.date.future?
        @event_list << event
      end
    end
    render 'show_events'
  end
  
  def past_events
    @user = User.find(params[:user_id])
    @events = @user.events
    @event_list = []
    @events.each do |event| 
      if event.date.past?
        @event_list << event
      end
    end
    render 'show_events'
  end

  private

    def event_params
      params.require(:event).permit(:date, :limit, :event_name, :detail)
    end
end
