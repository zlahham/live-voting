class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :vote]

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

  private

  def event_params
    params.require(:event).permit(:title, :id)
  end

end
