require 'rails_helper'

feature 'Events Features' do

  context 'when signed in' do

    before :each do
      @user = create(:user)
      sign_in_as(@user)
    end

    it 'has navbar contents' do
      expect(page).to have_content "Sign out"
    end

    context 'when creating events' do
      before(:each){ click_on 'Create Event' }

      it 'events can be created' do
        fill_in 'event_title', with: 'event 1'
        click_on 'Add Event'
        expect(page).to have_content 'event 1'
      end

      it "events cannot be created with a blank title field" do
        click_on 'Add Event'
        expect(page).to have_content "1 error prohibited this event from being saved:"
      end
    end

    context "after creating an event" do
      before(:each){ create_event("event 1") }

      context "when on events index page" do
        before(:each){ visit events_path }

        it "user's events are displayed" do
          expect(page).to have_content "event 1"
        end
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
    end
  end

  private

  def create_event(title)
    click_on 'Create Event'
    fill_in 'event_title', with: title
    click_on 'Add Event'
  end
end
