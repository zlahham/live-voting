class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :vote, :parse_event_id]

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

  def destroy
    Event.find(params[:id]).destroy
    redirect_to events_path
    flash[:notice] = "Event successfully deleted"
  end

  def vote
    @event = Event.find(params[:id])
  end

  def parse_event_id
    event = Event.find(params[:unparsed_event_id])
    redirect_to vote_event_path(event)
  end

  private

  def event_params
    params.require(:event).permit(:title)
  end

end
