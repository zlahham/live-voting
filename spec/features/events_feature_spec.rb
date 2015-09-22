require 'rails_helper'

feature 'events' do

  context 'user logged in' do

    before :each do
      user = create(:user)
      sign_in_as(user)
    end

    it 'lets events be created' do
      visit root_path
      click_on 'Create Event'
      fill_in 'event_title', with: 'event 1'
      click_on 'Add Event'
      expect(page).to have_content 'event 1'
    end
  end

  context 'user not logged in' do

    it 'does not allow events to be created' do
      visit root_path
      click_on 'Create Event'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(current_path).not_to be new_event_path
    end
  end
end
