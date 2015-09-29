require 'rails_helper'

feature 'Events Features' do
  let(:event){ create :event, user: create(:user) }

  context 'when signed in' do
    before(:each){ sign_in_as event.user }

    it "'Sign out' link is visible on home page" do
      visit root_path
      expect(page).to have_content "Sign out"
    end

    it 'events can be created' do
      visit events_path
      fill_in 'event_title', with: 'My Event'
      click_on 'Add Event'
      expect(current_path).to eq event_path(Event.last)
      expect(page).to have_content 'My Event'
      expect(page).to have_content 'Event created. Add some questions!'
    end

    it 'can be deleted' do
      visit events_path
      click_on 'Delete'
      expect(current_path).to eq events_path
      expect(page).not_to have_content "#{event.title}"
      expect(page).to have_content 'Event successfully deleted'
    end

    it 'can be edited' do
      click_on 'Create Event'
      fill_in 'event_title', with: 'event 1'
      visit events_path
      click_on 'Edit'
      expect(current_path).to eq edit_event_path(event)
      expect(page).to have_content 'Update Event'
    end

    context "when on events index page with one created event" do
      it "user's event is displayed" do
        expect(page).to have_content event.title
      end

      it "event name links to its event page" do
        click_on "#{event.title}"
        expect(current_path).to eq event_path(event)
      end
    end

    context 'Event Show Page' do
      before(:each){ visit event_path(event) }

      it 'user is shown an id for their event to give to their audience' do
        expect(event.code).to be_a String
        expect(page).to have_content "Event ID: #{event.code}"
      end

      it 'has a twitter share button' do
        expect(page).to have_css('.twitter-share-button')        
      end
    end
  end

  context 'when not signed in' do
    before(:each){ visit root_path }

    it "'Create Event' link is not visible on home page" do
      expect(page).not_to have_content 'Create Event'
    end

    it "'Sign in' link is visible on home page" do
      expect(page).to have_content "Sign in"
    end

  end

  context 'when wishing to vote' do
    before(:each){ visit root_path }

    it 'unsigned in event participant can go to event using event id' do
      within(:css, '#event_id_wrapper') do
        expect(page).to have_content "Click Here"
      end

      click_on 'Click Here'
      event_code = event.code
      new_code = "ABCD" + "#{event.id}"
      event.update_attributes(code: new_code)
      fill_in :unparsed_event_id, with: event.code
      click_on 'Go'
      expect(current_path).to eq vote_event_path(event)
      expect(page).to have_content "Awaiting Question"
    end

    it 'signed in event participant can go to event using event id' do
      sign_in_as event.user
      within(:css, '#event_id_wrapper') do
        expect(page).to have_content "Click Here"
      end

      click_on 'Click Here'
      event_code = event.code
      new_code = "ABCD" + "#{event.id}"
      event.update_attributes(code: new_code)
      fill_in :unparsed_event_id, with: event.code
      click_on 'Go'
      expect(current_path).to eq vote_event_path(event)
      expect(page).to have_content "Awaiting Question"
    end

    it 'user is shown message when event id is incorrectly entered' do
      incorrect_event_id = event.id + 1
      click_on 'Click Here'
      fill_in :unparsed_event_id, with: incorrect_event_id
      click_on 'Go'
      expect(current_path).to eq root_path
      expect(page).to have_content "Sorry, that id does not match any events. Please try again."
    end
  end
end
