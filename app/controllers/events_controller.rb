class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :voting_page]

  def index
    if @user ||= current_user
      @events = @user.events
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    
    if @event.save
      redirect_to event_path(@event)
    else
      render 'events/new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def voting_page
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title)
  end

end
