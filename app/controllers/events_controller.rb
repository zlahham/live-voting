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
      @event.update_attributes(code: generate_code(@event.id))
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
    if Event.exists?(params[:unparsed_event_id])
      event = Event.find(params[:unparsed_event_id])
      redirect_to vote_event_path(event)
    else
      redirect_to root_path
      flash[:alert] = "Sorry, that id does not match any events. Please try again."
    end
  end

  def generate_code(event_id)
    characters = %w(A B C D E F G H J K L M O P Q R T W X Y Z 1 2 3 4 5 6 7 8 9)
    code = ''
    4.times do
      code << characters.sample
    end
    code << event_id.to_s
    code
  end


  private

  def event_params
    params.require(:event).permit(:title)
  end
end