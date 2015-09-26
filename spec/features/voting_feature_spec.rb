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
          content: "hello",
          id: 15
        },
        {
          content: "hello",
          id: 16
        },
        {
          content: "dds",
          id: 17
        },
        {
          content: "",
          id: 18
        },
        {
          content: "",
          id: 19
        }
      ]
    }

    it "sends question to voter", js: :true do
      visit vote_event_path(event)
      expect(page).to have_content 'Awaiting Question'
      page.execute_script("$(document).ready(function() { buildQuestion(#{data.to_json}) });")
      expect(page).to have_content 'Test Question'
    end
  end
end
