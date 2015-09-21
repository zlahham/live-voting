class EventsController < ApplicationController

  def index
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.js.erb
    end
  end

  def create
    @event = Event.new(event_params)
    @event.save

    respond_to do |format|
      format.js.erb
    end
  end

  private

  def event_params
    params.require(:event).permit(:title)
  end

end