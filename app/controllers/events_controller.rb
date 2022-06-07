class EventsController < ApplicationController
  before_action :authenticate_user!, only: [
    :new, :select_restaurant, :edit, :update,
    :confirm, :create, :future, :past, :favorite,
  ]
  before_action :set_user, only: [:future, :past, :favorite]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def index
    @events = Event.search(event_search_params)
    respond_to do |format|
      format.html { redirect_to search_events_path }
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
    render(:new) && return if params[:back]
    @restaurant = Restaurant.new(session[:restaurant])
    Event.transaction do
      @restaurant.save
      @event.user_id = current_user.id
      @event.fix_event(@restaurant)
      Room.create!(event_id: @event.id)
      Membership.create!(user_id: current_user.id, event_id: @event.id)
      redirect_to event_path(@event.id)
    end
  end

  def show
  end

  def edit
    unless current_user == @event.planning_user
      redirect_to @event
    end
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event.id)
  end

  def destroy
    @event.destroy
    redirect_to user_path(current_user)
  end

  def future
    @title = "参加予定の宴会一覧"
    @events = @user.events
    @event_list = @events.map { |event| event if event.date.future? }.compact
    render 'show_events'
  end

  def past
    @title = "参加した宴会一覧"
    @events = @user.events
    @event_list = @events.map { |event| event if event.date.past? }.compact
    render 'show_events'
  end

  def favorite
    @title = "お気に入りした宴会一覧"
    @event_list = @user.favorite_events
    render 'show_events'
  end

  def search
    @event_search_params = event_search_params
    @events = Event.search(event_search_params) unless event_search_params.empty?
  end

  private

  def event_params
    params.require(:event).permit(:date, :limit, :event_name, :detail, :prefecture_id, :event_image)
  end

  def event_search_params
    params.fetch(:search, {}).permit(:event_name, :date, :prefecture_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
