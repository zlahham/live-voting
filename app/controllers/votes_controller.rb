class VotesController < ApplicationController
  def create
    @choice = Choice.find(params[:choice])
    @choice.votes.create
    render nothing: true
  end
end
