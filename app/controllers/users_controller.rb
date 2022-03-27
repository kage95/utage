class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @events = @user.events
    @favorite_events = @user.favorite_events if @user.favorite_events.exists?
    @future_events = []
    @past_events = []
      @events.each do |event| 
        if event.date.future?
          @future_events << event
        else
          @past_events << event
        end
      end
  end
end
