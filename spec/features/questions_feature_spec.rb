require 'rails_helper'

describe 'Questions Features' do
  let(:user){ create :user }

  before :each do
    sign_in_as(user)
    click_on 'Create Event'
    fill_in 'event_title', with: 'event 1'
    click_on 'Add Event'
  end

  it 'can be created on an event' do
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Add'
    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content 'test question'
  end

  context "when a question has been created and on the event show page" do
    before :each do
      event = create :event, user: user
      question = create :question, event: event   
      visit event_path(event)  
    end

    it "has a button to 'Publish' the question on the event show page" do
      expect(page).to have_selector(:link_or_button, 'Publish')
    end

    it "user can publish a question" do
      click_on 'Publish'
      expect(page).to have_content 'Question has been pushed to the audience'
    end
  end

  it "can't be created with a blank content field" do
    click_on 'Add Question'
    click_on 'Add'
    expect(page).to have_content "1 error prohibited this question from being saved:"
  end

  it 'has a web-link which takes you back to the original event' do
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Add'
    expect(page).to have_content 'Back to event 1'
  end
end
