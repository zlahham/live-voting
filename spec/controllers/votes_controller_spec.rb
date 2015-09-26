require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user){ create :user }

  before :each do
    event = create :event, user: user
    question = create :question, event: event
    @choice = create :choice, question: question
  end

  describe '#create' do
    it 'creates a vote on a choice when params contain a choice id' do
      allow(subject).to receive(:params).and_return(choice: @choice.id)
      expect_any_instance_of(Pusher::Client).to receive :trigger

      expect{ get(:create) }.to change{@choice.votes.count}.by 1
    end
  end

  describe '#build_json' do
    it "when passed a vote, it returns a json object with choice_id and that choice's vote count" do
      vote = create(:vote, choice: @choice)
      expect(JSON.parse(subject.build_json(vote))).to eq( {"choice_id" => @choice.id, "vote_count" => vote.choice.votes.count} )
    end
  end
end
