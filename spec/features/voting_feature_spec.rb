require 'rails_helper'

feature 'Voting Features' do
  # let(:event){ create :event, user: create(:user) }

  context 'when not signed in' do

    before(:each) do
      @event = create :event, user: create(:user)
      @question = create :question, event: @event
      @choice = create :choice, question: @question
      @choice2 = create :choice_2, question: @question
      @choice3 = create :choice_3, question: @question
      @data = {
        event: {
          id: @event.id,
          title: @event.title
        },
        question: {
          id: @question.id,
          content: @question.content,
          question_number: "1"
        },
        choices: [
          {
            content: @choice.content,
            id: @choice.id
          },
          {
            content: @choice2.content,
            id: @choice2.id
          },
          {
            content: @choice3.content,
            id: @choice3.id
          }
        ]
      }
    end

    it "can navigate to voting page and it says 'Awaiting Question'" do
      visit vote_event_path(@event)
      expect(page).to have_content 'Awaiting Question'
    end



    it "sends question to voter", js: :true do
      visit vote_event_path(@event)
      expect(page).to have_content 'Awaiting Question'
      page.execute_script("$(document).ready(function() { buildQuestion(#{@data.to_json}) });")
      expect(page).to have_content 'Question 1 of 1'
      expect(page).to have_content 'My Question'
      expect(page).to have_content 'Yes'
      expect(page).to have_content 'No'
      expect(page).to have_content 'Maybe'
    end
  end
end
