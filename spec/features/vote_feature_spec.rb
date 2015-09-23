require 'rails_helper'

describe 'Vote' do

  before :each do
    user = create(:user)
    sign_in_as(user)
    click_on 'Create Event'
    fill_in 'event_title', with: 'event 1'
    click_on 'Add Event'
  end

  it 'displays the event name' do
    visit vote_event_path(event.last)
    expect(page).to have_content 'event 1'
  end

end
