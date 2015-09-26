require 'rails_helper'

feature 'Voting Features' do
  let(:event){ create :event, user: create(:user) }

  context 'when not signed in' do
    it "can navigate to voting page and it says 'Awaiting Question'" do
      visit vote_event_path(event)
      expect(page).to have_content 'Awaiting Question'
    end
  end
end