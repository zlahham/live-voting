class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :vote, :parse_event_id]
  before_action :event_owner_check, only: [:show, :destroy, :edit, :update]

  def index
    @event = Event.new
    if @user ||= current_user
      @events = @user.events
    end
  end

  def new
    @event = Event.new
    render 'index'
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      @event.update_attributes(code: generate_code(@event.id))
      redirect_to event_path(@event)
      flash[:notice] = "Event created. Add some questions!"
    else
      redirect_to events_path
    end
  end

  def show
    @event = Event.find(params[:id])
    event_owner_check
  end


  def destroy
    Event.find(params[:id]).destroy
    redirect_to events_path
    flash[:notice] = "Event successfully deleted"
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @user ||= current_user
      @events = @user.events
    end

    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event successfully updated"
      render 'index'
    else
      render 'edit'
    end
  end

  def vote
    @event = Event.find(params[:id])
  end

  def parse_event_id
    event_code = params[:unparsed_event_id].upcase
    if Event.exists?(:code => event_code)
      event = Event.find_by code: event_code.to_s
      redirect_to vote_event_path(event)
    else
      redirect_to root_path
      flash[:alert] = "Sorry, that code does not match any events. Please try again."
    end
  end

  def generate_code(event_id)
    characters = %w(A B C D E F G H J K L M P Q R T W X Y Z 1 2 3 4 5 6 7 8 9)
    code = ''
    4.times do
      code << characters.sample
    end
    code << event_id.to_s
    code
  end

  private

  def event_owner_check
    event = Event.find(params[:id])
    if current_user != event.user
      redirect_to root_path, notice: "Sorry, but we were unable to serve your request."
    end
  end

  def event_params
    params.require(:event).permit(:title, :description)
  end
end
