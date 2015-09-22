require 'rails_helper'

describe 'Questions' do
  before :each do
    user = create(:user)
    sign_in_as(user)
    click_on 'Create Event'
    fill_in 'event_title', with: 'event 1'
    click_on 'Add Event'
  end

  it 'can be created on an event' do
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Publish'
    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content 'test question'
  end

  xit "can't be created with a blank content field"
end