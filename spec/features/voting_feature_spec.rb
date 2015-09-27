require 'rails_helper'

feature 'Voting Features' do
  let(:event){ create :event, user: create(:user) }

  context 'when not signed in' do
    it "can navigate to voting page and it says 'Awaiting Question'" do
      visit vote_event_path(event)
      expect(page).to have_content 'Awaiting Question'
    end

    data = {
      event: {
        id: 8,
        title: "Test Question"
      },
      question: {
        id: 10,
        content: "Test Question"
      },
      choices: [
        {
          content: "yes",
          id: 15
        },
        {
          content: "no",
          id: 16
        },
        {
          content: "maybe",
          id: 17
        }
      ]
    }

    it "sends question to voter", js: :true do
      visit vote_event_path(event)
      expect(page).to have_content 'Awaiting Question'
      page.execute_script("$(document).ready(function() { buildQuestion(#{data.to_json}) });")
      expect(page).to have_content 'Test Question'
      expect(page).to have_content 'yes'
      expect(page).to have_content 'no'
      expect(page).to have_content 'maybe'
    end
  end
end
