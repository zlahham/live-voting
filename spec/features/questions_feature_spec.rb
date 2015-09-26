require 'rails_helper'

describe 'Questions Features' do
  before :each do
    user = create :user
    sign_in_as(user)
    @event = create :event, user: user
  end

  it 'can be created on an event' do
    visit event_path(@event)
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Add'
    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content 'test question'
  end

  it "can't be created with a blank content field" do
    visit event_path(@event)
    click_on 'Add Question'
    click_on 'Add'
    expect(page).to have_content "1 error prohibited this question from being saved:"
  end

  context 'after a question has been created' do
    before(:each){ @question = create :question, event: @event }

    it "the question show page has a link back to its event" do
      visit question_path(@question)
      expect(page).to have_selector(:link_or_button, "Back to #{@event.title}")
    end

    it "event show page has a button to 'Publish' the question" do
      visit event_path(@event)
      expect(page).to have_selector(:link_or_button, 'Publish')
    end

    it "user can publish the question" do
      #this expect statement stubs the trigger method
      expect_any_instance_of(Pusher::Client).to receive(:trigger)
      visit event_path(@event)
      click_on 'Publish'
      expect(page).to have_content 'Question has been pushed to the audience'
    end
  end
end