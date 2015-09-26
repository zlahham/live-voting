require 'rails_helper'

describe 'Questions Features' do
  let(:event){ create :event, user: create(:user) }

  before :each do
    sign_in_as(event.user)
  end

  it 'can be created on an event' do
    visit event_path(event)
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Add'
    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content 'test question'
  end

  it "can't be created with a blank content field" do
    visit event_path(event)
    click_on 'Add Question'
    click_on 'Add'
    expect(page).to have_content "1 error prohibited this question from being saved:"
  end

  it 'can be deleted' do
    question = create :question, event: event
    visit event_path event
    expect(page).to have_content "#{question.content}"
    click_on 'Delete Question'
    expect(page).not_to have_content "#{question.content}"
    expect(page).to have_content "Question successfully deleted"
  end

  context 'after a question has been created' do
    before(:each){ @question = create :question, event: event }

    it "the question show page has a link back to its event" do
      visit question_path(@question)
      expect(page).to have_selector(:link_or_button, "Back to #{event.title}")
    end

    it "event show page has a button to 'Publish' the question" do
      visit event_path(event)
      expect(page).to have_selector(:link_or_button, 'Publish')
    end

    it "user can publish the question" do
      expect_any_instance_of(Pusher::Client).to receive(:trigger)
      visit event_path(event)
      click_on 'Publish'
      expect(current_path).to eq  question_path(@question)
      expect(page).to have_content 'Question has been pushed to the audience'
    end

    it "alerts user to issue publishing question" do
      expect_any_instance_of(Pusher::Client).to receive(:trigger).and_raise("ERROR")
      visit event_path(event)
      click_on 'Publish'
      expect(current_path).to eq  event_path(event)
      expect(page).to have_content 'Error: Question could not be published'
    end

  end
end
