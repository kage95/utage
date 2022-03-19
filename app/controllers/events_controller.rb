class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = Event.search(event_search_params)
    respond_to do |format|
      format.html {redirect_to search_events_path}
      format.js
    end
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
    @event.get_image
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
  
  def future
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
  
  def past
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
  
  def search
    @event_search_params = event_search_params
  end

  private

    def event_params
      params.require(:event).permit(:date, :limit, :event_name, :detail, :prefecture_id, :event_image)
    end
    
    def event_search_params
      params.fetch(:search, {}).permit(:event_name,:date)
    end
end