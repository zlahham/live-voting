class VotesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @choice = Choice.find(params[:choice])
    @choice.votes.create
    render nothing: true
  end
end
