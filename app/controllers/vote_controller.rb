class VoteController < ApplicationController

  def index
    @event = Event.find(params[:id])
  end

end
