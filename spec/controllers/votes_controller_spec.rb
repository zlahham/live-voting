require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe '#create' do
    it 'creates a vote on a choice when params contain a choice id' do
      choice = create(:choice)
      allow(subject).to receive(:params).and_return(choice: choice.id)

      expect{get(:create)}.to change{choice.votes.count}.by(1)
    end
  end
end
