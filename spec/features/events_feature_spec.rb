require 'rails_helper'

feature 'Events Features' do

  let(:user){ create :user }

  context 'when signed in' do
    it 'has navbar contents' do
      sign_in_as(user)
      expect(page).to have_content "Sign out"
    end

    context 'when creating events' do

      it 'events can be created' do
        sign_in_as(user)
        click_on 'Create Event'
        fill_in 'event_title', with: 'event 1'
        click_on 'Add Event'
        expect(page).to have_content 'event 1'
        expect(page).to have_link("voting page", href: "/events/#{Event.last.id}/vote")
      end

      it "events cannot be created with a blank title field" do
        sign_in_as(user)
        click_on 'Create Event'
        click_on 'Add Event'
        expect(page).to have_content "1 error prohibited this event from being saved:"
      end
    end
  end

  context "after creating an event" do

    context "when on events index page" do
      it "user's events are displayed" do
        create(:event, title: 'event 1', user: user)
        sign_in_as(user)
        visit events_path
        expect(page).to have_content "event 1"
      end

      it "event name links to its event page" do
        event = create(:event, title: 'event 1', user: user)
        sign_in_as(user)
        visit events_path
        click_on "event 1"
        expect(current_path).to eq event_path(event)
      end
    end

    context 'when on event show page' do
      it 'has a publish question button' do
        event = create(:event, title: 'event 1', user: user)
        sign_in_as(user)
        visit events_path
        click_on 'event 1'
        click_on 'Add Question'
        fill_in 'question_content', with: 'test question'
        click_on 'Add'
        visit event_path(event)
        expect(page).to have_selector(:link_or_button, 'Publish')
      end

      it 'publishes question' do
        expect_any_instance_of(Pusher::Client).to receive :trigger
        event = create(:event, title: 'event 1', user: user)
        sign_in_as(user)
        visit events_path
        click_on 'event 1'
        click_on 'Add Question'
        fill_in 'question_content', with: 'test question'
        click_on 'Add'
        visit event_path(event)
        click_on 'Publish'
        expect(page).to have_content 'Question has been pushed to the audience'
      end
    end

  end

  context 'when not signed in' do
    it 'has navbar contents' do
      visit root_path
      expect(page).to have_content "Sign in"
    end

    it 'events cannot be created' do
      visit root_path
      expect(page).not_to have_content 'Create Event'
    end

    it "can navigate to an event's voting page" do
      user = create :user
      event = create :event, title: "My Event", user: user
      visit vote_event_path(event)
      expect(page).to have_content "My Event"
      expect(page).to have_content "Question ? of 0"
    end
  end


end
