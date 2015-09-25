class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    choice = Choice.find(params[:choice])
    vote = choice.votes.new
    
    if vote.save
      json_object = build_json(vote)
      push_json(choice, json_object)
    end

    render nothing: true
  end

  def build_json(vote)
    json_object = { choice_id: vote.choice.id, vote_count: vote.choice.votes.count }.to_json
  end

  def push_json(choice, json_object)
    pusher = Pusher::Client.new app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret
    pusher.trigger('test_channel', 'event_question_' +
     choice.question_id.to_s + '_' + 'choice_' + choice.id.to_s, json_object )
  end
end