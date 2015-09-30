require 'rails_helper'

feature 'Voting Features' do
  # let(:event){ create :event, user: create(:user) }

  context 'when not signed in' do

    before(:each) do
      @event = create :event, user: create(:user)
      @question = create :question, event: @event
      @question2 = create :question, event: @event
      @choice = create :choice, question: @question
      @choice2 = create :choice_2, question: @question
      @choice3 = create :choice_3, question: @question
    end

    it "can navigate to voting page and it says 'Awaiting Question' and gives the event description" do
      visit vote_event_path(@event)
      expect(page).to have_content 'Event 1'
      expect(page).to have_content 'The first event of hopefully many, in which we show off our technology'
      expect(page).to have_content 'Awaiting Question'
    end

    it "sends question to voter", js: :true do
      visit vote_event_path(@event)
      expect(page).to have_content 'Awaiting Question'
      page.execute_script("$(document).ready(function() { buildQuestion(#{data_creator("1")}); });")
      expect(page).to have_content 'Question 1 of 2'
      expect(page).to have_content 'My Question'
      expect(page).to have_content 'Yes'
      expect(page).to have_content 'No'
      expect(page).to have_content 'Maybe'
      page.execute_script("$(document).ready(function() { answerSubmit(#{@choice.id}) });")
      expect(page).to have_content 'Results:'
      expect(page).to have_css("#choice_#{@choice.id} .progress .progress-bar")
    end
  end
end
