require 'rails_helper'

feature 'Events Features' do
  before :all do
    @user = create :user
    @event = create :event, user: @user
  end

  context 'when signed in' do
    before(:each){ sign_in_as @user }

    it "'Sign out' link is visible on home page" do
      visit root_path
      expect(page).to have_content "Sign out"
    end

    it 'events can be created' do
      click_on 'Create Event'
      fill_in 'event_title', with: 'event 1'
      click_on 'Add Event'
      expect(page).to have_content 'event 1'
      expect(page).to have_link("voting page", href: "/events/#{Event.last.id}/vote")
    end

    it "events cannot be created with a blank title field" do
      click_on 'Create Event'
      click_on 'Add Event'
      expect(page).to have_content "1 error prohibited this event from being saved:"
    end

    context "when on events index page with one created event" do
      it "user's event is displayed" do
        expect(page).to have_content @event.title
      end

      it "event name links to its event page" do
        click_on "#{@event.title}"
        expect(current_path).to eq event_path(@event)
      end
    end
  end

  context 'when not signed in' do
    it "'Create Event' link is not visible on home page" do
      visit root_path
      expect(page).not_to have_content 'Create Event'
    end

    it "'Sign in' link is visible on home page" do
      visit root_path
      expect(page).to have_content "Sign in"
    end
  end
end
