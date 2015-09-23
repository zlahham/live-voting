require 'rails_helper'

feature 'Events Features' do

  context 'user logged in' do

    before :each do
      @user = create(:user)
      sign_in_as(@user)
      visit root_path
      click_on 'Create Event'
    end

    it 'lets events be created' do
      fill_in 'event_title', with: 'event 1'
      click_on 'Add Event'
      expect(page).to have_content 'event 1'
    end

    it "can't be created with a blank title field" do
      click_on 'Add Event'
      expect(page).to have_content "1 error prohibited this event from being saved:"
    end

    context "when on events index page" do
      it "displays all the users events" do
        fill_in 'event_title', with: 'event 1'
        click_on 'Add Event'
        visit events_path
        click_on 'Create Event'
        fill_in 'event_title', with: 'event 2'
        click_on 'Add Event'
        visit events_path
        expect(page).to have_content "event 1"
        expect(page).to have_content "event 2"
      end
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
